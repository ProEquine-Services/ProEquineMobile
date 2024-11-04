import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/home/domain/cubits/home_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/create_shipping_request_model.dart';

class ChoseLocationScreen extends StatefulWidget {


  const ChoseLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChoseLocationScreen> createState() => _ChoseLocationScreenState();
}

class _ChoseLocationScreenState extends State<ChoseLocationScreen> {
  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _postalCodeController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  late CameraPosition initialPosition = const CameraPosition(
    target: LatLng(25.276987, 55.296249),
    zoom: 14.4746,
  );

  LatLng centerPosition = const LatLng(
    25.276987,
    55.296249,
  );
  List<Marker> markers = [];

  late Future mFuture;
  HomeCubit cubit = HomeCubit();

  @override
  void initState() {
    mFuture = getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Choose location",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
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
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: RebiInput(
                        hintText: 'Add Location Name'.tra,
                        controller: _locationController,
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
                              _locationController.text);
                        }
                      // onChanged: (value) {
                      //   _locationController.text = '';
                      // },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 35),
                    child:
                    RebiButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              final ChooseLocation location =
                              ChooseLocation(
                                  name: _locationController.text,
                                  lat: centerPosition.latitude.toString(),
                                  lng: centerPosition.longitude.toString());
                              Navigator.pop(context,location);

                            }

                          },
                          isLoading: false,
                          child: Text('Confirm'.tra),
                    ),
                  ),
                ]
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
    _locationController.text = '';
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
      target: LatLng(position.latitude, position.longitude),
      zoom: 12.0,
    );
    updateCenterMarker(LatLng(position.latitude, position.longitude));
    _goToPosition(LatLng(position.latitude, position.longitude));
    fillFormData(LatLng(position.latitude, position.longitude));

    return LatLng(position.latitude, position.longitude);
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
}
