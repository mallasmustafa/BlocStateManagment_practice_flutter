import 'dart:io';
import 'package:bloc_practice/bloc/image_pickr/image_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                if (state.file == null) {
                  return InkWell(
                    onTap: () {
                      context.read<ImagePickerBloc>().add(CameraCapture());
                      // context.read<ImagePickerBloc>().add(GalleryImagePicker());
                    },
                    child: const CircleAvatar(
                        child: Icon(Icons.camera_alt)
                    ),
                  );
                } else {
                  return Image.file(File(state.file!.path.toString()));
                }
              },

            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<ImagePickerBloc, ImagePickerState>(
            builder: (context, state) {
              if(state.file==null){
                return InkWell(
                  onTap: (){
                    context.read<ImagePickerBloc>().add(GalleryImagePicker());
                  },
                  child: const CircleAvatar(
                    child: Icon(Icons.browse_gallery_sharp,
                    ),
                  ),
                );
              }
              else{
                return Image.file(File(state.file!.path.toString()));
              }

            },
          ),
        ],
      ),
    );
  }
}
