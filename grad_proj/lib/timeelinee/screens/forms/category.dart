import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/login/responsive.dart';
import 'package:grad_proj/timeelinee/curved_navigation_bar.dart';
import 'package:grad_proj/timeelinee/screens/home/home_screen.dart';
import 'package:grad_proj/timeelinee/screens/stoks/stock.dart';

import '../../../admin/profile/widget/profile_widget.dart';
import '../../../dialog.dart';
import '../../../usrTime/screens/detailstore1/store1/componants/Categoriesviwe.dart';
import '../../../usrTime/screens/detailstore1/store1/componants/Subcat.dart';
import '../../../usrTime/screens/detailstore1/store1/componants/catcard.dart';
import '../../profilecompany/page/profile_page_company.dart';
import '../home/calendar/calendar.dart';
import 'formscom.dart';
import 'package:http/http.dart' as http;

class Cat extends StatefulWidget {
  const Cat({Key? key, required this.companyName}) : super(key: key);

  final String companyName;

  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
    String? _imagePath,_imagePath1,_imagePath2,_imagePath3;
      @override
  void initState() {
    super.initState();
    _initImage();
    _initImage2();
    _initImage3();

  }
    Future<void> _initImage() async {
    try {
      print("Fetching image for ${widget.companyName}");
      ListResult result = await FirebaseStorage.instance
          .ref()
          .child(widget.companyName)
          .listAll();

      List<Future<DateTime>> creationTimeFutures = result.items.map((file) {
        return file
            .getMetadata()
            .then((metadata) => metadata.timeCreated ?? DateTime(0));
      }).toList();

      List<DateTime> creationTimes = await Future.wait(creationTimeFutures);

      int latestIndex = creationTimes
          .indexOf(creationTimes.reduce((a, b) => a.isAfter(b) ? a : b));

      String latestFileURL = await result.items[latestIndex].getDownloadURL();

      setState(() {
        _imagePath = latestFileURL;
      });
    } catch (error) {
      print("Error initializing image: $error");
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result;

    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (result != null) {
      Uint8List? uploadFile = result.files.single.bytes;
      String fileName = result.files.single.name;

      Reference reference = FirebaseStorage.instance
          .ref()
          .child(widget.companyName)
          .child(fileName);

      final UploadTask uploadTask = reference.putData(uploadFile!);

      await uploadTask.whenComplete(() async {
        reference.getDownloadURL().then((fileURL) {
          setState(() {
            _imagePath = fileURL;
          });
        });
      });
    }
  }
    Future<void> _initImage2() async {
    try {
      print("Fetching image for ${widget.companyName}");
      ListResult result = await FirebaseStorage.instance
          .ref()
          .child(widget.companyName)
          .listAll();

      List<Future<DateTime>> creationTimeFutures = result.items.map((file) {
        return file
            .getMetadata()
            .then((metadata) => metadata.timeCreated ?? DateTime(0));
      }).toList();

      List<DateTime> creationTimes = await Future.wait(creationTimeFutures);

      int latestIndex = creationTimes
          .indexOf(creationTimes.reduce((a, b) => a.isAfter(b) ? a : b));

      String latestFileURL = await result.items[latestIndex].getDownloadURL();

      setState(() {
        _imagePath1 = latestFileURL;
      });
    } catch (error) {
      print("Error initializing image: $error");
    }
  }

  Future<void> _pickImage2() async {
    FilePickerResult? result;

    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (result != null) {
      Uint8List? uploadFile = result.files.single.bytes;
      String fileName = result.files.single.name;

      Reference reference = FirebaseStorage.instance
          .ref()
          .child(widget.companyName)
          .child(fileName);

      final UploadTask uploadTask = reference.putData(uploadFile!);

      await uploadTask.whenComplete(() async {
        reference.getDownloadURL().then((fileURL) {
          setState(() {
            _imagePath1 = fileURL;
          });
        });
      });
    }
  }
      Future<void> _initImage3() async {
    try {
      print("Fetching image for ${widget.companyName}");
      ListResult result = await FirebaseStorage.instance
          .ref()
          .child(widget.companyName)
          .listAll();

      List<Future<DateTime>> creationTimeFutures = result.items.map((file) {
        return file
            .getMetadata()
            .then((metadata) => metadata.timeCreated ?? DateTime(0));
      }).toList();

      List<DateTime> creationTimes = await Future.wait(creationTimeFutures);

      int latestIndex = creationTimes
          .indexOf(creationTimes.reduce((a, b) => a.isAfter(b) ? a : b));

      String latestFileURL = await result.items[latestIndex].getDownloadURL();

      setState(() {
        _imagePath2 = latestFileURL;
      });
    } catch (error) {
      print("Error initializing image: $error");
    }
  }

  Future<void> _pickImage3() async {
    FilePickerResult? result;

    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (result != null) {
      Uint8List? uploadFile = result.files.single.bytes;
      String fileName = result.files.single.name;

      Reference reference = FirebaseStorage.instance
          .ref()
          .child(widget.companyName)
          .child(fileName);

      final UploadTask uploadTask = reference.putData(uploadFile!);

      await uploadTask.whenComplete(() async {
        reference.getDownloadURL().then((fileURL) {
          setState(() {
            _imagePath2 = fileURL;
          });
        });
      });
    }
  }
    String _categoryName = '';
  String _categoryType = '';
    String _categoryName2 = '',Name='',parcode='',descrption='';
    int stok=0,price=0;
  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('اضف مجموعة'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ProfileWidget(
              imagePath: _imagePath ??
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
              onClicked: () async {
                _pickImage();
               
              },
            ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _categoryName = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'اسم المجموعة'),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _categoryType = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'نوع المجموعة'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('الغاء'),
              ),
              ElevatedButton(
                onPressed: () {
                _showCategoryDialog2() ;
                },
                child: Text('التالي'),
              ),
            ],
          ),
        );
      },
    );
  }
  void _showCategoryDialog2() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('اضف تصنيف فرعي للمجموعة'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ProfileWidget(
              imagePath: _imagePath1 ??
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
              onClicked: () async {
                _pickImage2();
               
              },
            ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _categoryName2 = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'اسم المجموعة'),
                ),
              
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('الغاء'),
              ),
              ElevatedButton(
                onPressed: () {
               _showCategoryDialog3();
                },
                child: Text('التالي'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCategoryDialog3() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('اضف منجات للمجموعة'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ProfileWidget(
              imagePath: _imagePath2 ??
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
              onClicked: () async {
                _pickImage3();
               
              },
            ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      Name = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'اسم المنتج'),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      parcode = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'الباركود'),
                ),
                  TextField(
                  onChanged: (value) {
                    setState(() {
                      price = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'سعر المنتج'),
                ),
                  TextField(
                  onChanged: (value) {
                    setState(() {
                      stok = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'كمية المنتج'),
                ),
                 TextField(
                  onChanged: (value) {
                    setState(() {
                      descrption = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'وصف المنتج'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('الغاء'),
              ),
              ElevatedButton(
                onPressed: () {
               addcat(_categoryName,_imagePath!,_categoryType);
                 showCards(context, "assets/thankyou.json",
                            "تمت الاضافة");
                },
                child: Text('انهاء'),
              ),
            ],
          ),
        );
      },
    );
  }

  
   Future<void> addcat(String _categoryName, String _imagePath, String _categoryType) async {
  const url = 'http://localhost:4000/add-pro/cat';
print(_categoryName);
print(_imagePath);
print(_categoryType);
print(_categoryName2);
print(_imagePath1);
print(Name);
print(_imagePath2);
print(price);
print(stok);


  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "companyName": widget.companyName,
      "categoryName": _categoryName,
      "categoryImage": "assets/images/1.jpg",
      "categoryType": _categoryType,
      "subcategories": [
        {
          "categoryName": _categoryName2,
          "categoryImage": "assets/images/2pcs-car-h1-h3-h4-h7-h8-h9-h11-h16-880-881.jpg",
          "products": [
            {
              "Name": Name,
              "proimage": "assets/images/image327.png",
              "parcode": parcode,
              "price": price,
              "stok": stok,
              "descrption": descrption,
              "company": widget.companyName
            }
          ]
        }
      ],
    }),
  );

  if (response.statusCode == 200) {
    print('Category added successfully');
  } else {
    print('Failed to add category');
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('المجموعات'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
            Categoriesviwe(item: widget.companyName),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                  _showCategoryDialog();
                  },
                  child: Text('اضغط لانشاء مجموعة'),
                ),
              ),
              const SizedBox(height: 20,),
               Center(
                child: ElevatedButton(
                  onPressed: () {
                  _showCategoryDialog();
                  },
                  child: Text(' تعديل مجموعة'),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Color(0xFF063970),
          ),
          child: CurvedNavigationBar(
            index: 2,
            color: const Color(0xFF063970),
            buttonBackgroundColor: const Color(0xFF063970),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            height: 75.0,
            items: const [
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.book, size: 30, color: Colors.white),
              Icon(Icons.add, size: 30, color: Colors.white),
              Icon(Icons.factory, size: 30, color: Colors.white),
              Icon(Icons.person, size: 30, color: Colors.white),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const HomeScreencom();
                    }),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return CalendarPage();
                    }),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const MyButtonsScreen();
                    }),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const StokScreenPage();
                    }),
                  );
                  break;
                case 4:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ProfilePageadCompany(
                        companyName: widget.companyName,
                      );
                    }),
                  );
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
