#  PlenyTask

## Features

* This project is fully coded in SwiftUI

* The code supports mostly 16+

* No third party liberaries are included, Instead of that every thing implemented using pure swift

* I have implemented the MVVM pattern as an architectural patten

* I have implemented a generic network layer using URLSession that can be implemented using any data type
* for asyncronous operations, I've implemented (aync / await) technology which is the latest introduced in swift, instead of combine or closures

* I have implemented the NetworkManager class that is used for both network layer and unit testing

* design patterns used :
    * coordinator
    * singleton

* for the project herarichy, there are several groups of files that manages the entire code

* the app supports dark theme as well as light theme

* some import notes regarding the implemented equations:-

    * for pagination in posts screen, I've configured paging to retreive 10 posts per page
    * for search, in order to call api the search word must contains at least 3 letters which will make search api not get called to much time

## Screenshot

<img width="392" alt="Screenshot 2023-03-20 at 5 55 39 PM" src="https://user-images.githubusercontent.com/33458355/226400679-acf4c842-15e6-4821-814c-c7e51df5a772.png">
<img width="392" alt="Screenshot 2023-03-20 at 5 55 29 PM" src="https://user-images.githubusercontent.com/33458355/226400715-2d548ac9-157a-4885-acbc-d74ca8a73f00.png">
<img width="392" alt="Screenshot 2023-03-20 at 5 54 30 PM" src="https://user-images.githubusercontent.com/33458355/226401219-c423ef30-46c8-4d83-8d29-eb82aa7cb3f5.png">
<img width="392" alt="Screenshot 2023-03-20 at 5 54 20 PM" src="https://user-images.githubusercontent.com/33458355/226401375-1e7a06f1-40eb-4bca-a45f-14f387ab3c55.png">
