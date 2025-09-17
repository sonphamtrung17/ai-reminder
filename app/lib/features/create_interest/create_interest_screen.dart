import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/create_interest/create_interest_cubit.dart';
import '../../components/components.dart';
import '../../resource/resource.dart';
import '../../theme/theme.dart';

enum AvatarType { url, assets, file }

enum Gender {
  male(value: false),
  female(value: true);

  const Gender({required this.value});

  final bool value;
}

@RoutePage()
class CreateInterestScreen extends StatefulWidget {
  const CreateInterestScreen({super.key});

  @override
  State<CreateInterestScreen> createState() => _CreateInterestScreenState();
}

class _CreateInterestScreenState extends BaseScreenState<CreateInterestScreen, CreateInterestCubit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  AvatarType imageType = AvatarType.assets;
  String? errorName;
  bool? isFeMale;
  List<File>? _mediaFileList;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  void _setImageFileListFromFile(XFile? value) {
    if (value == null) {
      _mediaFileList = null;
    } else {
      _mediaFileList = [File(value.path)];
    }
  }

  AvatarType _getTypeOfImage() {
    if (_mediaFileList == null || _mediaFileList!.isEmpty) {
      return AvatarType.assets;
    } else {
      return AvatarType.file;
    }
  }

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    bool allowMultiple = false,
  }) async {
    if (context.mounted) {
      if (allowMultiple) {
        try {
          final List<XFile> pickedFileList = await _picker.pickMultiImage(
            maxWidth: null,
            maxHeight: null,
            imageQuality: null,
            limit: null,
          );
          setState(() {
            _mediaFileList = pickedFileList.map((xFile) => File(xFile.path)).toList();
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
            logD('_pickImageError: $_pickImageError');
          });
        }
      } else {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: null,
            maxHeight: null,
            imageQuality: null,
          );
          setState(() {
            _setImageFileListFromFile(pickedFile);
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
            logD('_pickImageError: $_pickImageError');
          });
        }
      }
    }
  }

  void showBottomSheetChooseImageFile(BuildContext context, bool? isMultiPick) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: Dimens.d16, left: Dimens.d16, bottom: Dimens.d4),
              child: Text(
                S.current.chonKieuAnh,
                style: context.textStyle.bodySSemiBold.copyWith(fontSize: Dimens.d20, color: context.color.primary),
              ),
            ),
            if (_picker.supportsImageSource(ImageSource.camera))
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _onImageButtonPressed(ImageSource.camera, context: context);
                },
                child: ListTile(
                  leading: Icon(Icons.camera_alt, color: context.color.primary),
                  title: Text(
                    S.current.camera,
                    style: context.textStyle.bodyLRegular.copyWith(fontSize: Dimens.d16, color: context.color.primary),
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _onImageButtonPressed(
                  ImageSource.gallery,
                  context: context,
                  allowMultiple: isMultiPick ?? false,
                );
              },
              child: ListTile(
                leading: Icon(Icons.image_rounded, color: context.color.primary),
                title: Text(
                  S.current.photoGallery,
                  style: context.textStyle.bodyLRegular.copyWith(fontSize: Dimens.d16, color: context.color.primary),
                ), // Fixed: Using localized string
              ),
            ),
          ],
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _birthDayController.text = '${picked.day}/${picked.month}/${picked.year}'; // format đơn giản
      });
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backgroundColor: Colors.transparent,
        title: S.current.taoDoiTuong,
        showBack: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: context.color.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: AppImage.circle(
                              path: _getTypeOfImage() == AvatarType.assets
                                  ? Assets.images.imgPlaceholderAvt.path
                                  : null,
                              file: _getTypeOfImage() == AvatarType.file ? _mediaFileList![0] : null,
                              size: Dimens.d80,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: AppButton.icon(
                              iconPath: Assets.icons.icAddImage,
                              backgroundColor: Colors.transparent,
                              onPressed: () {
                                showBottomSheetChooseImageFile(context, false);
                              },
                              iconWidth: Dimens.d24,
                              iconHeight: Dimens.d24,
                            ),
                          ).wrapPadding(const EdgeInsets.only(top: Dimens.d46, left: Dimens.d56)),
                        ],
                      ).wrapPadding(const EdgeInsets.symmetric(vertical: Dimens.d12)),
                      AppTextField(
                        labelText: S.current.hoVaTen,
                        controller: _nameController,
                        errorText: errorName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            errorName = S.current.vuiLongNhapTen;
                            setState(() {});
                          } else {
                            errorName = null;
                            setState(() {});
                          }
                          return null;
                        },
                      ),
                      AppToggle(
                        values: [S.current.nam, S.current.nu],
                        onToggleCallback: (value) {
                          setState(() {
                            isFeMale = value;
                          });
                        },
                        buttonColor: context.color.primary,
                        backgroundColor: context.color.white,
                        textColor: context.color.white,
                        initialValue: Gender.male.value,
                      ).wrapPadding(const EdgeInsets.symmetric(vertical: Dimens.d12)),
                      AppTextField(
                        labelText: S.current.ngaySinh,
                        controller: _birthDayController,
                        readOnly: true,
                        suffixIcon: AppButton.icon(
                          iconPath: Assets.icons.icCalendarMonth,
                          width: Dimens.d14,
                          height: Dimens.d14,
                          backgroundColor: Colors.transparent,
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      const Space(height: Dimens.d12),
                      AppTextField(
                        labelText: S.current.moiQuanHe,
                      ),
                      const Space(height: Dimens.d12),
                      AppTextField(
                        labelText: S.current.ngheNghiep,
                      ),
                      const Space(height: Dimens.d12),
                      AppTextField(
                        labelText: S.current.soDienThoai,
                      ),
                      const Space(height: Dimens.d12),
                      AppTextField(
                        labelText: S.current.email,
                      ),
                      const Space(height: Dimens.d12),
                      AppTextField(
                        labelText: S.current.diaChi,
                      ),
                      const Space(height: Dimens.d12),
                      AppTextField(
                        labelText: S.current.ghiChu,
                      ),
                    ],
                  ).wrapPadding(const EdgeInsets.all(Dimens.d12)),
                ),
              ),
            ),
          ),
          AppButton.text(
            height: Dimens.d48,
            text: S.current.luuLai,
            buttonWidth: AppButtonWidth.matchParent,
            textStyle: context.textStyle.bodyLSemiBold.copyWith(
              color: context.color.white,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
          ).wrapPadding(const EdgeInsets.symmetric(vertical: Dimens.d16)),
        ],
      ).wrapPadding(const EdgeInsets.all(Dimens.d16)),
    );
  }
}
