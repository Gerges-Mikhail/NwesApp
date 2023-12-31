import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_to_bloc/Business%20Logic/news_bloc.dart';
import 'package:intro_to_bloc/data/models/Article.dart';
import 'package:intro_to_bloc/data/repository/respository.dart';
import '../constants/colors.dart';
import 'category_button.dart';
import '../widgets/post_card.dart';

class ListArticles extends StatefulWidget {
  const ListArticles({Key? key}) : super(key: key);

  @override
  State<ListArticles> createState() => _ListArticlesState();
}

class _ListArticlesState extends State<ListArticles> {
  String currentHeading = "J O E - N E W S";
  int selectedButtonID = 0;

  String selectedCategory =
      "topheadlines"; // This should be updated once we click the button
  List<bool> buttonStatus = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  final NewsRepository repository = NewsRepository();
  String selectedCountryEmoji = "🇺🇸";
  String selectedCountryCode = "us";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tagBackgroundColor,
        centerTitle: true,
        title: Text(currentHeading),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(width * 0.05),
              ),
            ),
            icon: Text(selectedCountryEmoji),
            color: Colors.red.shade400,
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "🇺🇸 United States",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "🇪🇬 Egypt",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            onSelected: (item) {
              selectedCountryEmoji = (item == 0) ? "🇺🇸" :"🇪🇬";
              selectedCountryCode = (item == 0) ? "us" : "eg" ;
              setState(() {});
              BlocProvider.of<NewsBloc>(context).add(
                GetArticlesEvent(
                    categoryName: selectedCategory,
                    countryName: selectedCountryCode),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.red.shade400,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              padding: EdgeInsets.only(
                  bottom: width * 0.02,
                  top: width * 0.02,
                  left: width * 0.015,
                  right: width * 0.015),
              scrollDirection: Axis.horizontal,
              children: [
                CategoryButton(
                  category: "top",
                  country: selectedCountryCode,
                  buttonID: 0,
                  isSelected: buttonStatus[0],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "business",
                  country: selectedCountryCode,
                  buttonID: 1,
                  isSelected: buttonStatus[1],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "entertainment",
                  country: selectedCountryCode,
                  buttonID: 2,
                  isSelected: buttonStatus[2],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "general",
                  country: selectedCountryCode,
                  buttonID: 3,
                  isSelected: buttonStatus[3],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "health",
                  country: selectedCountryCode,
                  buttonID: 4,
                  isSelected: buttonStatus[4],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "science",
                  country: selectedCountryCode,
                  buttonID: 5,
                  isSelected: buttonStatus[5],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "sports",
                  country: selectedCountryCode,
                  buttonID: 6,
                  isSelected: buttonStatus[6],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
                CategoryButton(
                  category: "technology",
                  country: selectedCountryCode,
                  buttonID: 7,
                  isSelected: buttonStatus[7],
                  onClicked: (category, id) {
                    selectedCategory = category;
                    selectedButtonID = id;
                    putOffOtherButtons(buttonStatus);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 14,
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitial) {
                  context
                      .read<NewsBloc>()
                      .add(GetArticlesEvent(categoryName: 'topheadlines'));
                } else if (state is NewsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: green,
                    ),
                  );
                } else if (state is NewsSuccessState) {
                  return RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<NewsBloc>(context).add(
                          GetArticlesEvent(
                              categoryName: selectedCategory,
                              countryName: selectedCountryCode),
                        );
                      },
                      child: buildArticles(context, state.articles));
                } else if (state is NewsErrorState) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<NewsBloc>(context).add(
                        GetArticlesEvent(
                            categoryName: selectedCategory,
                            countryName: selectedCountryCode),
                      );
                    },
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.error_outline),
                        Text("Connection Error!"),
                      ],
                    )),
                  );
                }
                return const Center(child: Text('Something Else Happened!'));
              },
            ),
          ),
        ],
      ),
      // body: FutureBuilder(
      //     future: repository.getArticles(),
      //     builder:
      //         (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
      //       if (snapshot.hasData) {
      //         List<Article>? articles = snapshot.data;
      //         return buildArticles(context, articles);
      //       } else {
      //         return const Center(
      //           child: Text("No Data!"),
      //         );
      //       }
      //     }),
    );
  }

  Widget buildArticles(BuildContext context, List<Article>? articles) {
    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: ListView.builder(
              padding: EdgeInsets.only(
                  left: width * 0.025, right: width * 0.025, top: width * 0.01),
              itemCount: articles!.length,
              itemBuilder: ((context, index) {
                return PostCard(
                  heigth: heigth * 0.451,
                  width: width,
                  padding: width * 0.03,
                  title: articles[index].title,
                  description: articles[index].description,
                  author: articles[index].author,
                  content: articles[index].content,
                  publishedAt: articles[index].publishedAt,
                  url: articles[index].url,
                  urlToImage: articles[index].urlToImage,
                );
              })),
        ),
      ],
    );
  }

  void putOffOtherButtons(List<bool> buttonStatus) {
    for (int i = 0; i < buttonStatus.length; i++) {
      if (i != selectedButtonID) {
        buttonStatus[i] = false;
      }
    }
    buttonStatus[selectedButtonID] = true;
    if (selectedCategory[1] == 'o') {
      currentHeading = 'Top Headlines';
    } else {
      selectedCategory = currentHeading =
          selectedCategory[0].toUpperCase() + selectedCategory.substring(1);
    }
  }
}
