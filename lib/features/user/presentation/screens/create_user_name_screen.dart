import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:proequine/features/user/presentation/screens/interests_screen.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/register_header.dart';

class CreateUserNameScreen extends StatefulWidget {
  const CreateUserNameScreen({
    super.key,
  });

  @override
  State<CreateUserNameScreen> createState() => _CreateUserNameScreenState();
}

class _CreateUserNameScreenState extends State<CreateUserNameScreen> {
  late final TextEditingController _userName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserCubit cubit = UserCubit();

  @override
  void initState() {
    _userName = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        RegistrationHeader(
                          isThereBackButton: false,
                          isThereSkip: false,
                        ),
                        const Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Create username",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "This can be anything you like and can be changed later remember keep it simple and unique. ",
                                    style: AppStyles.descriptions),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "@",
                                          style: TextStyle(
                                              color: AppColors.blackLight,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 15,
                                      child: RebiInput(
                                        hintText: 'Username'.tra,
                                        controller: _userName,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              _userName.text);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: BlocConsumer<UserCubit, UserState>(
                                    bloc: cubit,
                                    builder: (context, state) {
                                      if (state is CheckUsernameLoading) {
                                        return const LoadingCircularWidget();
                                      }
                                      return RebiButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              _onPressCheck('@${_userName.text}');

                                            } else {}
                                          },
                                          child: Text("Next", style: AppStyles.buttonStyle,));
                                    },
                                    listener: (context, state) {
                                      if (state is CheckUsernameSuccessful) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const InterestsScreen()));
                                      } else if (state is CheckUsernameError) {
                                        RebiMessage.error(
                                            msg: state.message!,
                                            context: context);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  _onPressCheck(String userName){
    cubit.checkUsername(userName);
  }
}
