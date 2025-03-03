//
//  ContentView.swift
//  NetworkingApp
//
//  Created by David Adekunle on 02/03/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var user: GHUser?
    var body: some View {
        
        NavigationStack {
            VStack (spacing: 20){
                AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundStyle(.secondary)
                }
                .frame(width: 120, height: 120)
                
                
                Text(user?.login ?? "loginPlaceholder")
                    .bold()
                    .font(.title3)
                
                Text("@\(user?.twitterUsername ?? "Social")")
                
                Text(user?.bio ?? "Bio placeholder")
                    .padding()
                
                Spacer()
            }
            .padding()
            .task{
                do{
                    user = try await getUser()
                } catch  {
                    // throw NetworkingError.invalidURL
                }
            }
            .navigationTitle("GitHub Profile")
        }
    }
    
    func getUser() async throws -> GHUser{
        let endpoint = "https://api.github.com/users/ryzendavid"
        
        guard let url = URL(string: endpoint) else{
            throw NetworkingError.invalidURL
        }
        
        //url Session
        let (data, response) = try await URLSession.shared.data(from: url)
        
        //response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw NetworkingError.invalidResponse
        }
        
        //converting json into gh user data object
        do {
            let decoder = JSONDecoder()
            
            //converts snakeCase labels to camelCase
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            //
            return try decoder.decode(GHUser.self, from: data)
        } catch{
            throw NetworkingError.inavalidData
        }
        
    }
    
   
}

#Preview {
    ContentView()
}
