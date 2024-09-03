import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekontaminasi/model/stats.dart';
import 'package:dekontaminasi/service/api_service.dart';
import 'package:dekontaminasi/ui/news_screen.dart';
import 'package:dekontaminasi/widget/rumah_sakit_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Future hospital = ApiService().getHospital();
  final Future news = ApiService().getNews();
  final Future status = ApiService().getStatus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dekontaminasi',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFE63946),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselWidget(),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Rumah Sakit Rujukan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              RumahSakitRujukan(hospital: hospital),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Status Terkini',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 130,
                        child: Card(
                          color: Colors.white,
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  //icon country
                                  Icons.flag,
                                  color: Colors.red,
                                ),
                                FutureBuilder(
                                  future: status,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else {
                                      Status status = snapshot.data!;
                                      StatusNumbers numbers = status.numbers!;
                                      final formatter = NumberFormat('#,###');
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${status.name!}',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Column(
                                           children: [
                                             Row(
                                               children: [
                                                 Icon(Icons.coronavirus, color: Colors.red),
                                                  Text(
                                                    'Terinfeksi: ${formatter.format(numbers!.infected)}',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w300,
                                                    ),
                                                  ),
                                               ],
                                             ),

                                           ],
                                          )
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: FutureBuilder(
                            future: status,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                Status status = snapshot.data!;
                                return SizedBox(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: status.regions!.length,
                                    itemBuilder: (context, index) {
                                      final region = status.regions![index];
                                      final formatter = NumberFormat('#,###');
                                      return Container(
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                      MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    status.regions![index].name!,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            child: Icon(
                                                              Icons.coronavirus,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          Text(
                                                            formatter.format(status
                                                                .regions![index]
                                                                .numbers!
                                                                .infected),
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight:
                                                                  FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.verified,
                                                            color: Colors.red,
                                                          ),
                                                          Text(
                                                            formatter.format(status
                                                                .regions![index]
                                                                .numbers!
                                                                .recovered),
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight:
                                                                  FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.sentiment_very_dissatisfied,
                                                            color: Colors.red,
                                                          ),
                                                          Text(
                                                            formatter.format(status
                                                                .regions![index]
                                                                .numbers!
                                                                .fatal),
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight:
                                                                  FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Text(
                                    'No data available'); // Tampilkan pesan jika tidak ada data
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Berita Terbaru',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              NewsWidget(news: news),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
    required this.news,
  });

  final Future news;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          child: FutureBuilder(
            future: news,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.map<Widget>(
                    (item) {
                      return Card(
                        elevation: 3,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.article_outlined,
                                color: Colors.red,
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    item.title,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            item.timestamp!)
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  print('${item.title} tapped.');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class CarouselWidget extends StatelessWidget {
  CarouselWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 150.0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          animateToClosest: true,
          scrollDirection: Axis.horizontal,
          viewportFraction: 0.8,
          disableCenter: true,
          initialPage: 0,
          aspectRatio: 16 / 9,
        ),
        items: [
          'https://w.wallhaven.cc/full/nm/wallhaven-nmk579.jpg',
          'https://w.wallhaven.cc/full/4x/wallhaven-4xlzvl.jpg',
          'https://w.wallhaven.cc/full/nm/wallhaven-nmk579.jpg',
          'https://w.wallhaven.cc/full/nm/wallhaven-nmk579.jpg',
          'https://w.wallhaven.cc/full/nm/wallhaven-nmk579.jpg',
        ].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        i,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
