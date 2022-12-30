import 'package:EasyPet/screens/show_image.dart';
import 'package:EasyPet/screens/utils/pet_adopted_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/details/detail_cubit.dart';
import '../blocs/details/detail_state.dart';
import '../model/pet.dart';

class DetailsPage extends StatelessWidget {
  final String petId;
  const DetailsPage( this.petId, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => DetailCubit(InitialState())..loadPetDetail(petId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff1b797a),
          toolbarHeight: 50,
          title: Text("Details"),
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_rounded)
          ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<DetailCubit,DetailState>(
            builder: (context,state) {
              Pet pet;
              if(state is InitialState){
                return CircularProgressIndicator();
              }

              if(state is PetAdopted) {
                pet = state.pet;
              }else{
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Something went wrong", style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
                );
              }

              return Stack(
                children: [

                  SizedBox(
                      width: screenWidth,
                      height: 400,
                      child: InkWell(
                        onTap: () {
                          showCupertinoModalPopup(context: context,
                              barrierColor: Colors.black.withOpacity(0.75),
                              builder: (BuildContext) =>
                                  ShowImage(pet.image)
                          );
                        },
                        child: Hero(
                            tag: pet.id,
                            child: Image.asset(pet.image,
                              fit: BoxFit.cover,)
                        ),
                      )
                  ),

                  Column(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 370,),

                      Container(
                        height: ScreenUtil().screenHeight -
                            ScreenUtil().statusBarHeight - 400 -
                            ScreenUtil().bottomBarHeight,
                        width: screenWidth,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius
                                .circular(10)),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 40,),

                            Row(
                              children: [
                                SizedBox(
                                  width: 90,
                                  child: Text("Name", style: GoogleFonts.lato(
                                      textStyle: TextStyle(fontSize: 22,
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.italic)
                                  ),),
                                ),

                                Text(":", style: GoogleFonts.lato(
                                    textStyle: TextStyle(fontSize: 22,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.italic)
                                ),),

                                SizedBox(width: 40,),

                                Text(pet.name,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(fontSize: 22,
                                          fontStyle: FontStyle.italic)
                                  ),),
                              ],
                            ),

                            SizedBox(height: 20,),

                            Row(
                              children: [
                                SizedBox(
                                  width: 90,
                                  child: Text("Age", style: GoogleFonts.lato(
                                      textStyle: TextStyle(fontSize: 22,
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.italic)
                                  ),),
                                ),

                                Text(":", style: GoogleFonts.lato(
                                    textStyle: TextStyle(fontSize: 22,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.italic)
                                ),),

                                SizedBox(width: 40,),

                                Text(pet.age,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(fontSize: 22,
                                          fontStyle: FontStyle.italic)
                                  ),),
                              ],
                            ),

                            SizedBox(height: 20,),

                            Row(
                              children: [
                                SizedBox(
                                  width: 90,
                                  child: Text("Price", style: GoogleFonts.lato(
                                      textStyle: TextStyle(fontSize: 22,
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.italic)
                                  ),),
                                ),

                                Text(":", style: GoogleFonts.lato(
                                    textStyle: TextStyle(fontSize: 22,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.italic)
                                ),),

                                SizedBox(width: 40,),

                                Text(
                                  "₹ " + pet.price.toString(),
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(fontSize: 22,
                                          fontStyle: FontStyle.italic)
                                  ),),
                              ],
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),


                  Positioned(
                    bottom: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, left: 15, right: 15),
                      child: BlocBuilder<DetailCubit, DetailState>(
                          builder: (context, state) {
                            if (state is InitialState) {
                              return TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty
                                          .all(
                                          Colors.white),
                                      backgroundColor: MaterialStateProperty
                                          .all(
                                          Color(0xffafaeae)),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(screenWidth - 30, 50))
                                  ),
                                  child: Text(
                                    "Adopt Me", style: GoogleFonts.roboto(
                                      textStyle: TextStyle(fontSize: 18,)),)
                              );
                            } else
                            if(state is PetAdopted && state.isAdoped==false){
                              Pet pet = state.pet;
                              return TextButton(
                                  onPressed: () {
                                    context.read<DetailCubit>().adopt(pet.id);
                                    // context.read<PetCubit>().reload();

                                    showCupertinoModalPopup(context: context,
                                        builder: (context) =>
                                            PetAdoptedMsg(pet.name)
                                    );
                                  },
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty
                                          .all(
                                          Colors.white),
                                      backgroundColor: MaterialStateProperty
                                          .all(
                                          Color(0xff1b797a)),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(screenWidth - 30, 50))
                                  ),
                                  child: Text(
                                    "Adopt Me", style: GoogleFonts.roboto(
                                      textStyle: TextStyle(fontSize: 18,)),)
                              );
                            }else {
                              return TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty
                                          .all(
                                          Colors.white),
                                      backgroundColor: MaterialStateProperty
                                          .all(
                                          Color(0xffafaeae)),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(screenWidth - 30, 50))
                                  ),
                                  child: Text(
                                    "Adopt Me", style: GoogleFonts.roboto(
                                      textStyle: TextStyle(fontSize: 18,)),)
                              );
                            }
                          }
                      ),
                    ),
                  )

                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
