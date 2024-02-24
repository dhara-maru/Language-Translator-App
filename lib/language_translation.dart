import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:google_fonts/google_fonts.dart';

class langtranspage extends StatefulWidget {
  const langtranspage({super.key});

  @override
  State<langtranspage> createState() => _langtranspageState();
}

class _langtranspageState extends State<langtranspage> {
  var languages = ['Hindi', 'English', 'Gujarati', 'Urdu', 'Marathi', 'Telugu'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languagesController = TextEditingController();

  void translate(String src, String dest, String input)async{
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
   setState(() {
     output = translation.text.toString();
   });

  if(src=='--' || dest=='--'){
    setState(() {
      output = "Failed to translate";
    });
  }
  }

  String getlangcode(String language){
    if(language=='English')
    {
      return "en";

    }else if(language=="Hindi"){
      return "hi";
    }
    else if(language=="Gujarati"){
      return "gu";
    }
    else if(language=="Urdu"){
      return "ur";
    }
    else if(language=="Marathi"){
      return "mr";
    }
    else if(language=="Telugu"){
      return "te";
    }
    else{
      return "--";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10223d),
      appBar: AppBar(
        title:  Text("Language Translator",style: GoogleFonts.jost(
      textStyle: TextStyle(
        fontSize: 24.0,
        
        color: Color(0xff10223d), // You can specify the color here
      ),
    ),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  focusColor: const Color(0xff10223d),
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    originLanguage,
                    style: GoogleFonts.jost(color: Colors.white),
                  ),
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: languages.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                      child: Text(dropDownStringItem),
                      value: dropDownStringItem,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      originLanguage = value!;
                    });
                  },
                ),
                const SizedBox(
                  width: 40,
                ),
                const Icon(
                  Icons.arrow_right_alt_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(
                  width: 40,
                ),
                DropdownButton(
                  focusColor: const Color(0xff10223d),
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    destinationLanguage,
                    style: GoogleFonts.jost(color: Colors.white),
                  ),
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: languages.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                      child: Text(dropDownStringItem),
                      value: dropDownStringItem,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      destinationLanguage = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: GoogleFonts.jost(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    labelText: "Please enter your text",
                    labelStyle: GoogleFonts.jost(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    )),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    )),
                    errorStyle: GoogleFonts.jost(
                      color: Colors.redAccent,
                      fontSize: 15,
                    )),
                controller: languagesController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text to translate';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(onPressed: () {translate(getlangcode(originLanguage), getlangcode(destinationLanguage), languagesController.text.toString());}, child: Text("Translate", style: GoogleFonts.jost(),),
              style: ElevatedButton.styleFrom(primary: Colors.white),),
            ),

            const SizedBox(height: 20,),

            Text("\n$output",
            style: GoogleFonts.jost(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),)
          ],
        ),
      )),
    );
  }
}
