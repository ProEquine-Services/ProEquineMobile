import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/home/data/edit_place_request_model.dart';
import 'package:proequine/features/home/data/new_place_request_model.dart';
import 'package:proequine/features/home/domain/cubits/home_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/delete_popup.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/new_place_response_model.dart';

class EditPlaceScreen extends StatefulWidget {
  final String category;
  final String name;
  final String lat;
  final String lng;
  final int placeId;

  const EditPlaceScreen({
    Key? key,
    required this.category,
    required this.placeId,
    required this.name,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  State<EditPlaceScreen> createState() => _EditPlaceScreenState();
}

class _EditPlaceScreenState extends State<EditPlaceScreen> {
  late TextEditingController locationController;

  final TextEditingController _postalCodeController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late CameraPosition initialPosition;

  LatLng centerPosition = const LatLng(
    25.276987,
    55.296249,
  );
  List<Marker> markers = [];

  late Future mFuture;
  HomeCubit cubit = HomeCubit();

  @override
  void initState() {
    initialPosition = CameraPosition(
      target: LatLng(double.parse(widget.lat), double.parse(widget.lng)),
      zoom: 14.4746,
    );
    locationController = TextEditingController(text: widget.name);
    Print(widget.category);
    mFuture = getCurrentPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<HomeCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Choose location",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Remove',
          isThereThirdOptionDelete: true,
          onPressThirdOption: () {
            deleteDialog(
                context: context,
                deleteButton: BlocConsumer<HomeCubit, HomeState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is DeletePlaceSuccessfully) {
                      RebiMessage.success(msg: state.message, context: context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      myCubit.getUserPlaces(
                          limit: 1000, category: widget.category);
                    } else if (state is DeletePlaceError) {
                      RebiMessage.error(msg: state.message!, context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is DeletePlaceLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.red,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.red),
                        ),
                      );
                    }
                    return RebiButton(
                        height: 35,
                        backgroundColor: AppColors.red,
                        onPressed: () {
                          onPressDelete();
                        },
                        child: Text(
                          "I'm sure",
                          style: AppStyles.buttonStyle,
                        ));
                  },
                ),
                title: "Are you sure you want to cancel this shipment");
          },
        ),
      ),
      body: FutureBuilder(
        future: mFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: RebiInput(
                      hintText: 'search location'.tra,
                      controller: _postalCodeController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) {
                        if (value != null && value.isNotEmpty) {
                          postalToLocation(value);
                        }
                      },
                      prefixIcon: const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.search),
                      ),
                      validator: Validator.requiredValidator,
                      onChanged: (value) {
                        // _locationController.text = '';
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: RebiInput(
                        hintText: 'Add Location Name'.tra,
                        controller: locationController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        // onFieldSubmitted: (value) {
                        //   if (value != null && value.isNotEmpty) {
                        //
                        //   }
                        // },

                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: false,
                        color: AppColors.formsLabel,
                        readOnly: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          return Validator.requiredValidator(
                              locationController.text);
                        }
                        // onChanged: (value) {
                        //   _locationController.text = '';
                        // },
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 52.h,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: map(),
                        ),

                        // const Positioned(
                        //   top: 20,
                        //   left: 20,
                        //   child: CustomBackButton(),
                        // ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kPadding, right: kPadding, bottom: 40),
                    child: BlocConsumer<HomeCubit, HomeState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is EditPlaceError) {
                          RebiMessage.error(
                              msg: state.message!, context: context);
                        } else if (state is EditPlaceSuccessfully) {
                          final AddNewPlaceResponseModel newPlaceModel =
                              AddNewPlaceResponseModel(
                                  name: locationController.text,
                                  desc: _postalCodeController.text,
                                  lat: centerPosition.latitude.toString(),
                                  lng: centerPosition.longitude.toString(),
                                  category: state.responseModel.category,
                                  id: state.responseModel.id,
                                  createdBy: state.responseModel.createdBy);

                          Navigator.pop(
                            context,
                            newPlaceModel,
                          );
                          myCubit.getUserPlaces(limit: 100);
                        }
                      },
                      builder: (context, state) {
                        if (state is EditPlaceLoading) {
                          return const LoadingCircularWidget();
                        }
                        return RebiButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.editPlace(EditPlaceRequestModel(
                                  id: widget.placeId,
                                  name: locationController.text,
                                  isDummy: true,
                                  lat: centerPosition.latitude,
                                  desc: _postalCodeController.text,
                                  lng: centerPosition.longitude,
                                  category: widget.category));
                            }
                          },
                          isLoading: false,
                          child: Text('Confirm'.tra),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: LoadingCircularWidget());
        },
      ),
    );
  }

  Future<void> _goToPosition(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: await controller.getZoomLevel(),
        ),
      ),
    );
  }

  updateCenterMarker(LatLng position) {
    centerPosition = position;
    setState(() {
      markers = [
        Marker(
          markerId: const MarkerId('center'),
          position: position,
        )
      ];
    });
  }

  Widget map() {
    return Container(
      height: 60.h,
      width: 100.w,
      color: Colors.grey,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        zoomControlsEnabled: false,
        onTap: (position) {
          updateCenterMarker(position);
          _goToPosition(position);
          fillFormData(position);
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
    );
  }

  void fillFormData(LatLng position) async {
    locationController.text = '';
    _postalCodeController.text = '';

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placeMarks.isNotEmpty) {
      Placemark place = placeMarks.first;
      Print.inf(place.toJson());
      if (place.street != null && place.street!.isNotEmpty) {
        _postalCodeController.text += place.street!;
      }
      if (place.subLocality != null && place.subLocality!.isNotEmpty) {
        _postalCodeController.text += ', ${place.subLocality!}';
      }
      if (place.administrativeArea != null &&
          place.administrativeArea!.isNotEmpty) {
        _postalCodeController.text += ', ${place.administrativeArea!}';
      }

      // _postalCodeController.text = place.postalCode.toString();
    }
  }

  Future<LatLng> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return centerPosition;
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return centerPosition;
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return centerPosition;
      // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    initialPosition = CameraPosition(
      target: LatLng(double.parse(widget.lat), double.parse(widget.lng)),
      zoom: 12.0,
    );
    updateCenterMarker(
        LatLng(double.parse(widget.lat), double.parse(widget.lng)));
    _goToPosition(LatLng(double.parse(widget.lat), double.parse(widget.lng)));
    fillFormData(LatLng(double.parse(widget.lat), double.parse(widget.lng)));

    return LatLng(double.parse(widget.lat), double.parse(widget.lng));
  }

  postalToLocation(String postalCode) async {
    List<Location> locations = [];
    try {
      locations = await locationFromAddress(
        postalCode,
      );
      Print(locations);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng position = LatLng(location.latitude, location.longitude);
        updateCenterMarker(position);
        _goToPosition(position);
        fillFormData(position);
      }
    } catch (e) {
      RebiMessage.error(msg: 'Location cannot be found.'.tra, context: context);
      Print.err(e);
    }
  }
  onPressDelete(){
    cubit.deletePlace(widget.placeId);
  }
}
