import 'package:flutter/material.dart';
import 'package:mvvm/screen/profile%20screen/profile_screen.dart';
import 'package:mvvm/service/remote_services.dart';
import 'package:geolocator/geolocator.dart';
import '../../service/apis/get_notes_data.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final now = DateTime.now();
  List<Post>? posts;
  var isloaded = false;
  @override
  void initState() {
    super.initState();

    print(DateTime.now());

    getdata();
  }

  getdata() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // await Geolocator.openLocationSettings();
    print(position);
    print('-------------------------------');
  }

  // void getHTTP() async {
  //   try {
  //     var response = await Dio().get(
  //       'http://103.143.40.250:8100/api/note/type/getnotetype',
  //     );
  //     print(response);
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FinalNotesWidget(isloaded: isloaded, posts: posts),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('-------------------------------');

          // getHTTP();
          print('-------------------------------');
          print(DateTime.now());
          print('-------------------------------');
          getLocation();
          print('-------------------------------');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FinalNotesWidget extends StatelessWidget {
  const FinalNotesWidget({
    Key? key,
    required this.isloaded,
    required this.posts,
  }) : super(key: key);

  final bool isloaded;
  final List<Post>? posts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Visibility(
        visible: isloaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.92,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${posts![index].createdAt}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  'усалгаатай - 1',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  posts![index].name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 127, 127, 127),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            width: MediaQuery.of(context).size.width * 0.92,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                'assets/images/note.jpeg',
                              )),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text(
                            posts![index].name,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Line3(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
