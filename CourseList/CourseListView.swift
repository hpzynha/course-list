//
//  ContentView.swift
//  CourseList
//
//  Created by Larissa Nogueira da Rocha on 17/3/2024.
//

import SwiftUI

struct CourseListView: View {
    
    @State var courses: [Course] = []
    
    var body: some View {
        if courses.count == 0 {
            VStack{
                ProgressView()
                    .padding()
                Text("We're grabbing the courses")
            }
            .foregroundColor(Color.purple)
            .onAppear { getCourses() }
        } else {
            List(courses) { course in
                Text(course.title)
            }
        }
        
    }
    
    func getCourses() {
        if let apiURL = URL(string: "https://zappycode.com/api/courses?format=json"){
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let courseData = data{
                    
                    //                    print(String(data: courseData, encoding: .utf8) ?? "ERROR")
                    if  let coursesFromApi = try? JSONDecoder().decode([Course].self, from: courseData){
                        courses = coursesFromApi
                        print(courses)
                    }
                    
                }
            }.resume()
        }
    }
}

#Preview {
    CourseListView()
}
