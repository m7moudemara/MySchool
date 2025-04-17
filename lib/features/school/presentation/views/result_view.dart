import 'package:MySchool/core/app_session.dart';
import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/core/constants.dart'; 
import 'package:MySchool/features/school/data/data_sources/results_api.dart'; 
import 'package:MySchool/features/school/data/repositories/result_repository_impl.dart'; 
import 'package:MySchool/features/school/domain/entities/result.dart'; 

class ResultView extends StatefulWidget {
  const ResultView({super.key, });
  static String id = '/ResultView';
  

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  bool _showDetails = false; 
  String _selectedTerm = ''; 
  late Future<List<Result>> _resultsFuture; 
  
  Student? student;
  
   
  
  @override
  void initState() {
    super.initState();
     final user = AppSession.currentUser;
  if (user is Student) {
    student = user;
  }
    final repository = ResultRepositoryImpl(ResultsApi());
    _resultsFuture = repository.getResults(); 
  }

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
      body:
          _showDetails
              ? _buildDetailsView()
              : _buildMainView(),
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
  return FutureBuilder<List<Result>>(
    future: _resultsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      }

      final results = snapshot.data!;
      final totalScore = results.fold(0, (sum, item) => sum + item.score);
      final maxScore = results.length * 100;
      final percentage = (totalScore / maxScore) * 100;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        Row(
  children: [
    _buildProgressCircle(percentage),
    const SizedBox(width: 16),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name: ${student?.name ?? ""}',
          style: const TextStyle(
            color: Color(0xFF3F3D56),
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
           "Grad: ${getGrade(totalScore)}",
          style: const TextStyle(
            color: Color(0xFF3F3D56),
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  ],
),

            Text(
              _selectedTerm,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final result = results[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.asset(result.icon,height: 52,width: 52,),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  
                                  result.subject,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.41,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SmallCircle(result: result.score.toString()),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 20),
                      ),
                    ),

                    Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
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
                                shape: const OvalBorder(),
                              ),
                              child: Center(
                                child: Text(
                                  totalScore.toString(),
                                  style: const TextStyle(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}


  Widget _buildProgressCircle(double percentage) {
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Overall", style: TextStyle(color: Colors.grey)),
            ],
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


String getGrade(int totalScore) {
  const int maxScore = 500;
  int difference = maxScore - totalScore;

  switch (difference) {
    case <= 50:
      return "A";
    case <= 100:
      return "B";
    case <= 200:
      return "C";
    case <= 300:
      return "D";
    default:
      return "F";
  }
}
