import 'package:flutter/material.dart';

double sliderTextSize = 32;

class TextOverImage extends StatefulWidget {
  @override
  _TextOverImageState createState() => _TextOverImageState();
}

List myColors = <Color>[
  Colors.transparent,
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.orange,
  Colors.indigo,
];

Color primaryColor = myColors[0];
TextEditingController userInput  = TextEditingController();


class _TextOverImageState extends State<TextOverImage> {
  bool textFieldOption = false;
  bool colorFilter = false;
  textFieldToggle() {
    setState(() {
      textFieldOption = !textFieldOption;
    });
  }

  colorFieldToggle() {
    setState(() {
      colorFilter = !colorFilter;
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text('Yoro Project'),
      ),
      body: Center(

        child: Stack(
          children: <Widget>[
            buildImage(),
            DraggableText(),
            Visibility(
              visible: colorFilter,
              child: buildColorIcons(),
            ),
            Visibility(
              visible: textFieldOption,
              child: Positioned(
                bottom: 100,
                right: 20,
                left: 20,
                child: Column(
                  children: [
                    TextField(
                      controller: userInput,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Please write something....",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    Slider(
                      min: 0,
                      max: 100,
                      value: sliderTextSize,
                      onChanged: (value) {
                        setState(() {
                          sliderTextSize = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        textFieldToggle();
                      },
                      icon: Icon(
                        Icons.text_fields,
                        size: 38,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        colorFieldToggle();
                      },
                      icon: Icon(
                        Icons.color_lens_outlined,
                        size: 38,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(primaryColor, BlendMode.hue),
          child: Container(
            color: Colors.white,
            child: Image.asset(
              "assets/image/whoisbenjamin-5dt0GJzSaTA-unsplash.jpg",
              fit: BoxFit.fitHeight
            ),
          ),
        ),
      );
  Widget buildColorIcons() => Positioned(
        bottom: 35,
        right: 10,
        child: Row(
          children: [for (var i = 0; i < 6; i++) buildIconBtn(myColors[i])],
        ),
      );

  Widget buildIconBtn(Color myColor) => Container(
        child: Stack(
          children: [
            Positioned(
              top: 12.5,
              left: 12.5,
              child: Icon(
                Icons.check,
                size: 20,
                color: primaryColor == myColor ? myColor : Colors.transparent,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.circle,
                color: myColor.withOpacity(0.65),
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  primaryColor = myColor;
                });
              },
            ),
          ],
        ),
      );
}

class DraggableText extends StatefulWidget {
  @override
  _DraggableTextState createState() => _DraggableTextState();
}

class _DraggableTextState extends State<DraggableText> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                offset = Offset(
                    offset.dx + details.delta.dx, offset.dy + details.delta.dy);
              });
            },
            child: SizedBox(
              width: 300,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(userInput.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sliderTextSize,
                          color: Colors.white)),
                ),
              ),
            )),
      ),
    );
  }
}
