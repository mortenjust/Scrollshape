//
//  Test.swift
//  Scrollshape
//
//  Created by Morten Just on 6/15/23.
//

import SwiftUI

struct Test: View {
    @State var from = 0.0
    @State var to = 1.0
    
    var body: some View {
        ScrollView {
            Text("heyo").frame(maxWidth: .infinity, alignment: .leading)
            Color.gray
                .frame(height: 7000)
        }.environment(\.layoutDirection, .rightToLeft)
            
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}


