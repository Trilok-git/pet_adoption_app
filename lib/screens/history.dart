import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/history/history_cubit.dart';
import '../blocs/history/history_state.dart';
import '../model/pet.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);

  final screenHeight = ScreenUtil().screenHeight;
  final screenWidth = ScreenUtil().screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> HistoryCubit(InitialState())..loadAdoptedPets(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1b797a),
          toolbarHeight: 50,
          title: Text("History"),
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_rounded)
          ),
        ),
        body: SingleChildScrollView(
          child:  Column(
              children: [

                SizedBox(height: 20,),

                BlocBuilder<HistoryCubit,HistoryState>(
                  builder: (context,state) {
                    List<Pet> petList = [];
                    if(state is InitialState){
                      return SizedBox(height:screenHeight-ScreenUtil().statusBarHeight-120, child: Center(child: CircularProgressIndicator(),));
                    }else if(state is PetLoaded) {
                      petList = state.pets;
                    }

                    return petList==[]? Text("History is empty.",style: TextStyle(fontSize: 18,),textAlign: TextAlign.center,)
                    :Column(
                      children: petList.asMap().entries.map<Widget>((entry) {
                        return showCard(entry.value);
                      }).toList(),
                    );
                  }
                ),

                SizedBox(height: 20,)


              ],
          ),
        )
      ),
    );
  }

  showCard(Pet Pet) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        height: 140,
        width: screenWidth,
        decoration: BoxDecoration(
          color: isDarkMode? Colors.black87 :Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: isDarkMode? Colors.grey.shade600 :Colors.grey.shade400,offset: Offset(0,1),spreadRadius: 1,blurRadius: 2)
          ]
        ),
        child: Row(
          children: [

              SizedBox.square(
                dimension: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(Pet.image,fit: BoxFit.cover,)
                ),
              ),

              SizedBox(width: 15,),

              Padding(
                padding: const EdgeInsets.symmetric( vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name",style:GoogleFonts.acme(fontSize: 15,color: Colors.grey.shade400)),
                    SizedBox(height: 5,),
                    Text(Pet.name,style: GoogleFonts.acme(fontSize: 17,color: isDarkMode? Colors.white: Color(0xff052031))),

                    SizedBox(height: 15,),

                    Text("Age",style:GoogleFonts.acme(fontSize: 15,color: Colors.grey.shade400)),
                    SizedBox(height: 5,),
                    Text(Pet.age,style: GoogleFonts.acme(fontSize: 17,color: isDarkMode? Colors.white: Color(0xff052031))),

                  ],
                ),
              ),

              SizedBox(width: 80,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price",style:GoogleFonts.acme(fontSize: 15,color: Colors.grey.shade400)),
                    SizedBox(height: 5,),
                    Text("₹ ${Pet.price}",style: GoogleFonts.acme(fontSize: 17,color: isDarkMode? Colors.white: Color(0xff052031))),

                  ],
                ),
              )

          ],
        ),
      ),
    );
  }
}
