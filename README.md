# NYArticles
NY Times articles app is implemented using mvvm, clean architecture(usecases) and coordinator pattern.

# Content

 * Overview
 * Screen shots
 * How to run the app
 * How to run the unit tests

 # Overview
 * This project is created by using clean architecture with MVVM-C.The app contain contains two screen i.e listing and detail. Each view controller contains a view model which is responsible for getting data from the use case and providing it to view controller to display it. The navigation in the app is implemented via coordinator.

 # Screen shots

 ![list](https://github.com/uzair/NYTimesArticles/assets/342173/b9a76d85-b469-4cef-bb70-910b78fef834)
![detail](https://github.com/uzair/NYTimesArticles/assets/342173/9333a544-7538-4503-9b68-7cc0d6c29547)

# How to run the app

The app requires the minimum iOS target 13.0. Please sse the latest xcode to run the app. After check out please run pod install as cocoapods is used to integrate AlamofireImage in the project.

# How to run the unit tests

The unit tests can be run from the test navigator and coverage report can be seen from report navigator.
Below is the test coverage of some of the important classes in the project.

	•	ArticleListViewModel (98.4%)
	•	ArticleDetailViewModel (100%)
	•	GetArticlesMetaDataUseCase (100%)
	•	ArticleRepository (100%)
	•	ArticleRemoteDataSource (100%)
	•	ArticlesMetaDataRequestDescriptor (100%)
	•	ServiceManager (100%)
	•	Service Client(93.7 %)

<img width="1052" alt="coverage 3" src="https://github.com/uzair/NYTimesArticles/assets/342173/a0257132-fa49-46b1-9d40-d354aad26913">


