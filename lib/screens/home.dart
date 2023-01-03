import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/details/detail_cubit.dart';
import '../blocs/home/counter_cubit.dart';
import '../blocs/home/home_state.dart';
import '../blocs/home/pet_cubit.dart';
import '../model/pet.dart';
import 'details_page.dart';
import 'history.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    int totalPets = Pet.PetsList.length;
    int rem = totalPets%6;
    int totalPages;
    if(rem!=0) {
      totalPages = (totalPets / 6).toInt() +1;
    }else{
      totalPages = (totalPets / 6).toInt();
    }

    BlocProvider.of<PetCubit>(context).loadPets();
    BlocProvider.of<CounterCubit>(context).getInitial();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 120,
          title: Container(
            // color: Colors.green,
            child: Column(
              children: [

                Text("Easy Pet",style: TextStyle(fontSize: 20,color: Colors.white),),

                SizedBox(height: 10,),

                Container(
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar()
                ),

              ],
            ),
          ),
        ),
        body: GestureDetector(
          onTapDown: (details) => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            height: screenHeight,
            width: screenWidth,
            // color: Colors.lightGreen,
            padding: EdgeInsets.fromLTRB(15,0,15,0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Our Pets",style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,color: isDarkMode? Colors.white: Color(
                          0xff020311)),),

                      BlocBuilder<CounterCubit, int>(
                        builder: (context, state) => Row(
                          children: [
                            state==1? Icon(Icons.arrow_back_ios_new_rounded,color: isDarkMode?Colors.white38 :Colors.grey.shade500,size: 16,)
                            : InkWell(
                              onTap: (){
                                context.read<PetCubit>().prevPage();
                                context.read<CounterCubit>().getPage();
                              },
                              child: Icon(Icons.arrow_back_ios_rounded,size: 16,color: isDarkMode?Colors.white70 :Colors.black87),
                            ),

                            Text(state.toString()+"/"+(totalPages).toString(),style: TextStyle(fontSize: 18, color: isDarkMode?Colors.white70 :Colors.black87 ),),

                            state==totalPages? Icon(Icons.arrow_forward_ios_rounded,color: isDarkMode?Colors.white38 :Colors.grey.shade500,size: 16,)
                            :InkWell(
                              onTap: (){
                                context.read<PetCubit>().nextPage();
                                context.read<CounterCubit>().getPage();
                              },
                              child: Icon(Icons.arrow_forward_ios_rounded,size: 16, color: isDarkMode?Colors.white70 :Colors.black87,)
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10,),

                  BlocBuilder <PetCubit, HomeState>(
                    builder: (context, state) {

                      if(state is PetLoading && state.isFetched==false){
                        return SizedBox(height: 200,child: Center(child: CircularProgressIndicator()));
                      }

                      List<Pet> pet = [];
                      if(state is InitialState ){
                        pet = state.pets;
                      }else if(state is PetLoaded){
                        pet = state.pets;
                      }else{
                        pet = [];
                      }
                        return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.83,
                          shrinkWrap: true,
                          primary: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: pet.asMap().entries.map((e){
                            bool isAdopted = e.value.isAdopted;

                            return showCard(context,e,isAdopted);
                          }).toList(),
                        );
                    }),

                  SizedBox(height: 20,)

                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            onPressed: () async {
              print(DetailCubit.adoptedPetId);
              print("starting");
              final prefs = await SharedPreferences.getInstance();
              final List<String>? adoptedPet = prefs.getStringList('adoptedPets');
              if(adoptedPet != null) {
                DetailCubit.adoptedPetId = adoptedPet;
              }
              print(adoptedPet);
              print(DetailCubit.adoptedPetId);

              Navigator.push(context,
                MaterialPageRoute(builder: (context) => History())
              );
            },
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history),
                Text("History",style: TextStyle(fontSize: 10),)
              ],
            ),

          ),
        ),
      ),
    );
  }


  Widget SearchBar(){
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Builder(
      builder: (context) {
        return TextFormField(
          // initialValue: "Search",
          // cursorColor: blu,
          onChanged: (value){
            context.read<PetCubit>().search(value);
          },
          autofocus: false,
          decoration: InputDecoration(
            hintText: "Search...",
            hintStyle: TextStyle(fontSize: 16,height: 0.7,color: isDarkMode? Colors.white :Color(
                0xffa8a8a8)),
            fillColor: isDarkMode? Color(0xff020212) : Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xff636363))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue)
            ),
          ),
        );
      }
    );
  }

  Widget showCard(context, e, isAdopted) {

    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Card(
      color: isAdopted?Colors.grey.shade300 : Theme.of(context).cardColor,
      elevation: 3,
      child: InkWell(
        onTap: (){
          if(!isAdopted) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    DetailsPage(e.value.id))
            ).then((value) {
              BlocProvider.of<PetCubit>(context).refresh();
              CounterCubit.currentPage = 1;
              CounterCubit().getPage();

            });
          }

        },
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
              bottom: Radius.circular(3)
          ),
          child: Container(
            foregroundDecoration: BoxDecoration(
              color: isAdopted?Colors.grey :Colors.white.withOpacity(0),
              backgroundBlendMode: isAdopted? BlendMode.saturation :BlendMode.color,
            ),
            decoration: BoxDecoration(
              // color: isDarkMode? I
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (ScreenUtil().screenWidth-55)/2,
                  height: ((ScreenUtil().screenWidth-55)/2)*0.78,
                  child: Hero(
                      tag: "${e.value.id}",
                      child: Image.asset(e.value.image,
                        fit: BoxFit.cover,)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e.value.name,
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(
                            0xff1b797a)),),
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                          text: "Price: ",
                          style: TextStyle(
                              color: Color(0xff148b9a),
                              fontSize: 14),
                          children: [
                            TextSpan(
                                text: "₹" + e.value.price
                                    .toString(),
                                style: TextStyle(fontSize: 16,
                                    fontWeight: FontWeight
                                        .w600,
                                    color: Color(0xff148b9a))
                            )
                          ]
                      ),

                    )
                )


              ],
            ),
          ),
        ),
      ),
    );
  }

}
