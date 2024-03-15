import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ml/componant/constants.dart';
import 'package:flutter_ml/componant/custom_outline.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MlModel extends StatefulWidget
{
  @override
  State<MlModel> createState()=>_MlModel();


}

class _MlModel extends State<MlModel> {
  String? result;
  final picker=ImagePicker();
  File? img;
  var url="https://fawaz-production.up.railway.app/predict";
  Future pickImage() async{
    PickedFile? pickedFile=await picker.getImage(source: ImageSource.gallery,);
    setState(() {
      img=File(pickedFile!.path);
    });
  }
  upload() async {
    if (img == null) {
      print("No image selected");
      return;
    }

    final request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers['Content-Type'] = 'multipart/form-data'; // Correct content-type header
    request.files.add(
      http.MultipartFile(
        'file',
        img!.readAsBytes().asStream(),
        img!.lengthSync(),
        filename: img!.path.split('/').last,
      ),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    print("Response: $responseBody");
    result = responseBody ;
    //result = responseBody ;
    // if (response.statusCode == 200) {
    //   final resJson = jsonDecode(responseBody);
    //   print("Response: $resJson");
    //   result = resJson['prediction'];
    // } else {
    //   print("Error ${response.statusCode}: $responseBody");
    // }

    setState(() {
      // Update UI if necessary
    });
  }
  @override
  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.kBlackColor,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Constants.kGreenColor,
        title: Text('Tomato Care',style: TextStyle(
          fontSize: 24,
          color: Constants.kBlackColor,
        )),
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(children: [
          Positioned(
            top: screenHeight*0.1,
            left: -88,
            child: Container(
              height: 166,
              width: 166,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.kGreenColor
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.3,
            right: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.kGreenColor,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          SafeArea(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight*0.05,),
              CustomOutline(
                strokeWidth: 4,
                radius: screenWidth * 0.8,
                padding: const EdgeInsets.all(4),
                width: screenWidth * 0.8,
                height: screenWidth * 0.8,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Constants.kGreenColor,
                      Constants.kGreenColor.withOpacity(0),
                      Constants.kGreenColor.withOpacity(0.1),
                      Constants.kGreenColor
                    ],
                    stops: const [
                      0.2,
                      0.4,
                      0.6,
                      1
                    ]),
                child: Center(
                  child: img == null
                      ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomLeft,
                        image:
                        //AssetImage('assets/img-onboarding.png'),
                        AssetImage('assets/img-onboarding.png'),
                      ),
                    ),
                  )
                      :  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomLeft,
                        image:
                        FileImage(img!),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.05,),
              Center(
                  child: img==null?
                  Text('THE MODEL HAS NOT BEEN PREDICTED',textAlign: TextAlign.center,
                    style: TextStyle(color: Constants.kWhiteColor.withOpacity(0.85,),fontSize: screenHeight<= 667 ? 18 : 34,
                      fontWeight: FontWeight.w700,),
                  )
                      :
                  Text('Result : $result',textAlign: TextAlign.center,
                    style: TextStyle(color: Constants.kWhiteColor.withOpacity(0.85,),fontSize: screenHeight<= 667 ? 18 : 34,
                      fontWeight: FontWeight.w700,),
                  )

              ),
              SizedBox(height: screenHeight*0.03,),
              CustomOutline(
                strokeWidth: 3,
                radius: 20,
                padding: const EdgeInsets.all(3),
                width: 160,
                height: 38,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Constants.kGreenColor, Constants.kGreenColor],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Constants.kGreenColor.withOpacity(0.5),
                        Constants.kGreenColor.withOpacity(0.5)
                      ],
                    ),
                  ),
                  child:ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white12,),

                    ),
                    onPressed: (){
                      pickImage();
                    },
                    child: Text('Pick Image Here',style: TextStyle(
                      fontSize: 14,
                      color: Constants.kWhiteColor,
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CustomOutline(
                strokeWidth: 3,
                radius: 20,
                padding: const EdgeInsets.all(3),
                width: 160,
                height: 38,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Constants.kGreenColor, Constants.kGreenColor],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Constants.kGreenColor.withOpacity(0.5),
                        Constants.kGreenColor.withOpacity(0.5)
                      ],
                    ),
                  ),
                  child:ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white12,),

                    ),
                    onPressed: (){
                      upload();

                    },
                    child: Text('Upload Image',style: TextStyle(
                      fontSize: 14,
                      color: Constants.kWhiteColor,
                    )),
                  ),
                ),
              ),
            ],
          ),),
        ]
        ),
      ),
    );
  }
}