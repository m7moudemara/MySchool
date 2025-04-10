
import 'package:MySchool/constants.dart';
import 'package:flutter/material.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});
  static String id = '/ResultView';

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  bool _showDetails = false;
  String _selectedTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        leading:
            _showDetails
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _showDetails = false;
                    });
                  },
                )
                : null,
      ),
      body: _showDetails ? _buildDetailsView() : _buildMainView(),
    );
  }

  Widget _buildMainView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTermCard(term: 'First Term', image: 'assets/result1.png'),
          const SizedBox(height: 17),
          _buildTermCard(term: 'Second Term', image: 'assets/result2.png'),
        ],
      ),
    );
  }

  Widget _buildTermCard({required String term, required String image}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDetails = true;
          _selectedTerm = term;
        });
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(top: 33.0, bottom: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 7),
                child: Text(
                  term,
                  style: TextStyle(
                    color: const Color(0xFF0C46C4),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Container(
                  height: 71,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16, top: 10),
                    child: Text(
                      'VIEW',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xFF0C46C4),
                        fontSize: 15,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildProgressCircle(context, percentage: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ......',
                    style: TextStyle(
                      color: const Color(0xFF3F3D56),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Grade: .....',
                    style: TextStyle(
                      color: const Color(0xFF3F3D56),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 360,
            height: 482.46,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.84, color: const Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(7.37),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/icons8-english-96.png", height: 50),
                      Text(
                        '  English',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.41,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SmallCircle(result: '95'),
                      
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/icons8-math-100.png", height: 50),
                      Text(
                        '   Maths',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.41,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SmallCircle(result: '95'),
                      
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/icons8-experiment-100.png", height: 50),
                      Text(
                        '   Science',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.41,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SmallCircle(result: '95'),
                      
                    ],
                  ),
              
                  Row(
                    children: [
                      Image.asset("assets/icons8-earth-globe-52.png", height: 50),
                      Text(
                        '   Social',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.41,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SmallCircle(result: '95'),
                      
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/icons8-ankh-100.png", height: 50),
                      Text(
                        '   History',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.41,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SmallCircle(result: '95'),
                      
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 81.02,
                        height: 81.02,
                        decoration: ShapeDecoration(
                          color: AppColors.kPrimaryColor,
                          shape: OvalBorder(),
                        ),
                        child: Center(
                          child: Text(
                            '477',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmallCircle extends StatelessWidget {
  const SmallCircle({required this.result, super.key});
  final String result;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.83,
      height: 36.83,
      decoration: ShapeDecoration(
        color: const Color(0xFF103568),
        shape: OvalBorder(),
      ),
      child: Center(
        child: Text(
          result,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.57,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

Widget _buildProgressCircle(BuildContext context, {double percentage = 50}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.3,

          child: CircularProgressIndicator(
            value: percentage / 100,
            strokeWidth: 10,
            backgroundColor: Colors.black,
            color: const Color(0xFF325CB9),
          ),
        ),
        Column(
          children: [
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Overall",
              style: TextStyle(
                color: const Color(0xFF5F5F5F),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
