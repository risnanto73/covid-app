import 'package:flutter/material.dart';

class RumahSakitRujukan extends StatelessWidget {
  const RumahSakitRujukan({
    super.key,
    required this.hospital,
  });

  final Future hospital;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: FutureBuilder(
          future: hospital,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text('Detail Rumah Sakit'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nama : ${snapshot.data[index].name}'),
                                Text('Alamat : ${snapshot.data[index].address}'),
                                Text('Telepon : ${snapshot.data[index].phone}'),
                              ],
                            ),
                          );
                        });
                      },
                      child: SizedBox(
                        width: 300,
                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_hospital_outlined,
                                  color: Colors.red,
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data[index].name,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      snapshot.data[index].address,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
