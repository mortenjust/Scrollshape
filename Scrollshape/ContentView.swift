//
//  ContentView.swift
//  Scrollshape
//
//  Created by Morten Just on 6/13/23.
//

import SwiftUI

struct ContentView: View {
    @State var currentY: CGFloat = .zero
    let endAt = 85.0
    var progress: Double { abs(currentY) / endAt }
    let padding = 64.0
    var opacity : Double { 0.5 + progress * 0.5 }
    var lineWidth: Double { 3 }
    var lineColor: Color { .white }
    @State  var go = false
    @State var loading = false
    
    var from: Double { progress.mapped(to: (0, 0.8)) }
    var to: Double { progress.mapped(to: (0.2, 1)) }
    
    var body: some View {
        VStack {
            
            ZStack {
                Color.black
                Color.blue
                    .cornerRadius(32)
                    .padding(.top, padding)
                    .padding(.horizontal, 2)
                ObservableScrollView(scrollOffset: $currentY) { _ in
                    Rectangle().fill(Color.black.gradient)
                        .frame(height: 3000)
                        .cornerRadius(32)
                }
                .cornerRadius(32)
                .padding(.top, padding)
                .scrollIndicators(.never)
                VStack {
                    
                    ZStack {
                        let w : Double = 49
                        var d : Double { w * 0.5 }
                        Circle()
                            .stroke(lineColor.opacity(opacity),
                                    style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round,
                                                 dash: [d * 0.5 ,d * 0.5 ]))
                            .rotationEffect(.degrees(go ? 0 : 360))
                            .frame(width: w).offset(x: 1, y:2)
                            .opacity(loading ? 1 : 0)
                        Twirl()
                            .trim(from: from, to:  to)
                            .stroke(lineColor.opacity(opacity), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                            .frame(height: 143)
                            .padding(.leading, 2)
                            .offset(y: 30)
                            .padding(.top, 34)
                            .opacity(loading ? 0 : 1)
                        
                    }
                    .offset(x: -3, y: 3)
                    Spacer()
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, 30)
            .background(Color.black)
            .ignoresSafeArea()
            .onChange(of: progress, perform: { newValue in
                withAnimation(.default) {
                    if newValue >= 1 { loading = true } else { loading = false }
                }
                
            })
            .onAppear {
                withAnimation(.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                    go = true
                }
            }
        }
    }
}

/// Reveals a circle
struct Twirl: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99284*width, y: 0.96187*height))
        path.addCurve(to: CGPoint(x: 0.99284*width, y: 0.20157*height), control1: CGPoint(x: 0.99396*width, y: 0.57359*height), control2: CGPoint(x: 0.99284*width, y: 0.35658*height))
        path.addCurve(to: CGPoint(x: 0.91977*width, y: 0.0159*height), control1: CGPoint(x: 0.99284*width, y: 0.0159*height), control2: CGPoint(x: 0.94572*width, y: 0.0159*height))
        path.addLine(to: CGPoint(x: 0.50076*width, y: 0.0159*height))
        path.addLine(to: CGPoint(x: 0.50076*width, y: 0.01588*height))
        path.addCurve(to: CGPoint(x: 0.43688*width, y: 0.18623*height), control1: CGPoint(x: 0.46548*width, y: 0.01588*height), control2: CGPoint(x: 0.43688*width, y: 0.09215*height))
        path.addCurve(to: CGPoint(x: 0.50076*width, y: 0.35658*height), control1: CGPoint(x: 0.43688*width, y: 0.28031*height), control2: CGPoint(x: 0.46548*width, y: 0.35658*height))
        path.addCurve(to: CGPoint(x: 0.56464*width, y: 0.18623*height), control1: CGPoint(x: 0.53604*width, y: 0.35658*height), control2: CGPoint(x: 0.56464*width, y: 0.28031*height))
        return path
    }
}

//
// /// Reveals a "Refresh" handwritten shape
//struct RefreshShape: Shape {
//    static var trimStart: (Double, Double) = (0, 1)
//    static var trimEnd: (Double, Double) = (0, 1)
//    
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let width = rect.size.width
//        let height = rect.size.height
//        path.move(to: CGPoint(x: 0.00826*width, y: 0.29441*height))
//        path.addCurve(to: CGPoint(x: 0.03207*width, y: 0.29058*height), control1: CGPoint(x: 0.00028*width, y: 0.29441*height), control2: CGPoint(x: 0.02444*width, y: 0.2941*height))
//        path.addCurve(to: CGPoint(x: 0.04953*width, y: 0.27894*height), control1: CGPoint(x: 0.038*width, y: 0.28784*height), control2: CGPoint(x: 0.04385*width, y: 0.28277*height))
//        path.addCurve(to: CGPoint(x: 0.06716*width, y: 0.26704*height), control1: CGPoint(x: 0.05547*width, y: 0.27493*height), control2: CGPoint(x: 0.0614*width, y: 0.27167*height))
//        path.addCurve(to: CGPoint(x: 0.09079*width, y: 0.24178*height), control1: CGPoint(x: 0.07545*width, y: 0.26037*height), control2: CGPoint(x: 0.08476*width, y: 0.25308*height))
//        path.addCurve(to: CGPoint(x: 0.10093*width, y: 0.21943*height), control1: CGPoint(x: 0.09455*width, y: 0.23473*height), control2: CGPoint(x: 0.09729*width, y: 0.22657*height))
//        path.addCurve(to: CGPoint(x: 0.10843*width, y: 0.20038*height), control1: CGPoint(x: 0.10398*width, y: 0.21345*height), control2: CGPoint(x: 0.10642*width, y: 0.20714*height))
//        path.addCurve(to: CGPoint(x: 0.11063*width, y: 0.19469*height), control1: CGPoint(x: 0.1089*width, y: 0.19877*height), control2: CGPoint(x: 0.11056*width, y: 0.19181*height))
//        path.addCurve(to: CGPoint(x: 0.11023*width, y: 0.25315*height), control1: CGPoint(x: 0.1111*width, y: 0.21376*height), control2: CGPoint(x: 0.1117*width, y: 0.23421*height))
//        path.addCurve(to: CGPoint(x: 0.10591*width, y: 0.28126*height), control1: CGPoint(x: 0.10949*width, y: 0.2627*height), control2: CGPoint(x: 0.10654*width, y: 0.27179*height))
//        path.addCurve(to: CGPoint(x: 0.10477*width, y: 0.2845*height), control1: CGPoint(x: 0.1056*width, y: 0.28603*height), control2: CGPoint(x: 0.10337*width, y: 0.29613*height))
//        path.addCurve(to: CGPoint(x: 0.10843*width, y: 0.24112*height), control1: CGPoint(x: 0.10651*width, y: 0.26999*height), control2: CGPoint(x: 0.10768*width, y: 0.25582*height))
//        path.addCurve(to: CGPoint(x: 0.11142*width, y: 0.21943*height), control1: CGPoint(x: 0.1088*width, y: 0.23376*height), control2: CGPoint(x: 0.10871*width, y: 0.22583*height))
//        path.addCurve(to: CGPoint(x: 0.11716*width, y: 0.20805*height), control1: CGPoint(x: 0.11307*width, y: 0.21553*height), control2: CGPoint(x: 0.11398*width, y: 0.20996*height))
//        path.addCurve(to: CGPoint(x: 0.1384*width, y: 0.21202*height), control1: CGPoint(x: 0.1234*width, y: 0.20431*height), control2: CGPoint(x: 0.13235*width, y: 0.21029*height))
//        path.addCurve(to: CGPoint(x: 0.16062*width, y: 0.21222*height), control1: CGPoint(x: 0.14541*width, y: 0.21402*height), control2: CGPoint(x: 0.15383*width, y: 0.21674*height))
//        path.addCurve(to: CGPoint(x: 0.17094*width, y: 0.20276*height), control1: CGPoint(x: 0.16443*width, y: 0.20968*height), control2: CGPoint(x: 0.16739*width, y: 0.2058*height))
//        path.addCurve(to: CGPoint(x: 0.16521*width, y: 0.18398*height), control1: CGPoint(x: 0.17764*width, y: 0.19702*height), control2: CGPoint(x: 0.17062*width, y: 0.18487*height))
//        path.addCurve(to: CGPoint(x: 0.14396*width, y: 0.21043*height), control1: CGPoint(x: 0.15485*width, y: 0.18228*height), control2: CGPoint(x: 0.14564*width, y: 0.19648*height))
//        path.addCurve(to: CGPoint(x: 0.14991*width, y: 0.2675*height), control1: CGPoint(x: 0.14173*width, y: 0.22888*height), control2: CGPoint(x: 0.14123*width, y: 0.25222*height))
//        path.addCurve(to: CGPoint(x: 0.17134*width, y: 0.27835*height), control1: CGPoint(x: 0.15437*width, y: 0.27536*height), control2: CGPoint(x: 0.16432*width, y: 0.28419*height))
//        path.addCurve(to: CGPoint(x: 0.18963*width, y: 0.26697*height), control1: CGPoint(x: 0.17703*width, y: 0.2736*height), control2: CGPoint(x: 0.18398*width, y: 0.2724*height))
//        path.addCurve(to: CGPoint(x: 0.21895*width, y: 0.22181*height), control1: CGPoint(x: 0.20135*width, y: 0.25573*height), control2: CGPoint(x: 0.21064*width, y: 0.23822*height))
//        path.addCurve(to: CGPoint(x: 0.24395*width, y: 0.17307*height), control1: CGPoint(x: 0.22719*width, y: 0.20552*height), control2: CGPoint(x: 0.2362*width, y: 0.18986*height))
//        path.addCurve(to: CGPoint(x: 0.25902*width, y: 0.11706*height), control1: CGPoint(x: 0.25175*width, y: 0.15615*height), control2: CGPoint(x: 0.2556*width, y: 0.13684*height))
//        path.addCurve(to: CGPoint(x: 0.26202*width, y: 0.0873*height), control1: CGPoint(x: 0.26072*width, y: 0.10723*height), control2: CGPoint(x: 0.26129*width, y: 0.09735*height))
//        path.addCurve(to: CGPoint(x: 0.26101*width, y: 0.07308*height), control1: CGPoint(x: 0.26237*width, y: 0.08252*height), control2: CGPoint(x: 0.26262*width, y: 0.07739*height))
//        path.addCurve(to: CGPoint(x: 0.25567*width, y: 0.07064*height), control1: CGPoint(x: 0.25985*width, y: 0.07001*height), control2: CGPoint(x: 0.25774*width, y: 0.07056*height))
//        path.addCurve(to: CGPoint(x: 0.24456*width, y: 0.0914*height), control1: CGPoint(x: 0.24916*width, y: 0.07086*height), control2: CGPoint(x: 0.24696*width, y: 0.08411*height))
//        path.addCurve(to: CGPoint(x: 0.23447*width, y: 0.13081*height), control1: CGPoint(x: 0.24044*width, y: 0.10396*height), control2: CGPoint(x: 0.23721*width, y: 0.11743*height))
//        path.addCurve(to: CGPoint(x: 0.23204*width, y: 0.19707*height), control1: CGPoint(x: 0.23016*width, y: 0.1518*height), control2: CGPoint(x: 0.23204*width, y: 0.17544*height))
//        path.addCurve(to: CGPoint(x: 0.22331*width, y: 0.39863*height), control1: CGPoint(x: 0.23204*width, y: 0.26434*height), control2: CGPoint(x: 0.23225*width, y: 0.33233*height))
//        path.addCurve(to: CGPoint(x: 0.20868*width, y: 0.45061*height), control1: CGPoint(x: 0.22094*width, y: 0.41624*height), control2: CGPoint(x: 0.2168*width, y: 0.43674*height))
//        path.addCurve(to: CGPoint(x: 0.19889*width, y: 0.44479*height), control1: CGPoint(x: 0.20407*width, y: 0.45847*height), control2: CGPoint(x: 0.20124*width, y: 0.45237*height))
//        path.addCurve(to: CGPoint(x: 0.19995*width, y: 0.35043*height), control1: CGPoint(x: 0.18911*width, y: 0.41329*height), control2: CGPoint(x: 0.19242*width, y: 0.38203*height))
//        path.addCurve(to: CGPoint(x: 0.22957*width, y: 0.27716*height), control1: CGPoint(x: 0.20645*width, y: 0.32312*height), control2: CGPoint(x: 0.22045*width, y: 0.30239*height))
//        path.addCurve(to: CGPoint(x: 0.2368*width, y: 0.24231*height), control1: CGPoint(x: 0.23343*width, y: 0.26649*height), control2: CGPoint(x: 0.23553*width, y: 0.25421*height))
//        path.addCurve(to: CGPoint(x: 0.23552*width, y: 0.21235*height), control1: CGPoint(x: 0.23785*width, y: 0.2326*height), control2: CGPoint(x: 0.23949*width, y: 0.22113*height))
//        path.addCurve(to: CGPoint(x: 0.22869*width, y: 0.20064*height), control1: CGPoint(x: 0.23427*width, y: 0.20958*height), control2: CGPoint(x: 0.23107*width, y: 0.20163*height))
//        path.addCurve(to: CGPoint(x: 0.21745*width, y: 0.20924*height), control1: CGPoint(x: 0.22474*width, y: 0.19901*height), control2: CGPoint(x: 0.21999*width, y: 0.20571*height))
//        path.addCurve(to: CGPoint(x: 0.21317*width, y: 0.21943*height), control1: CGPoint(x: 0.21594*width, y: 0.21133*height), control2: CGPoint(x: 0.21247*width, y: 0.21573*height))
//        path.addCurve(to: CGPoint(x: 0.23204*width, y: 0.23463*height), control1: CGPoint(x: 0.21459*width, y: 0.22684*height), control2: CGPoint(x: 0.22781*width, y: 0.23238*height))
//        path.addCurve(to: CGPoint(x: 0.25461*width, y: 0.23173*height), control1: CGPoint(x: 0.24021*width, y: 0.23898*height), control2: CGPoint(x: 0.24741*width, y: 0.23988*height))
//        path.addCurve(to: CGPoint(x: 0.27154*width, y: 0.20303*height), control1: CGPoint(x: 0.26124*width, y: 0.22423*height), control2: CGPoint(x: 0.26666*width, y: 0.21301*height))
//        path.addCurve(to: CGPoint(x: 0.27683*width, y: 0.19476*height), control1: CGPoint(x: 0.27184*width, y: 0.20242*height), control2: CGPoint(x: 0.27592*width, y: 0.19358*height))
//        path.addCurve(to: CGPoint(x: 0.27723*width, y: 0.20527*height), control1: CGPoint(x: 0.27793*width, y: 0.19617*height), control2: CGPoint(x: 0.27725*width, y: 0.204*height))
//        path.addCurve(to: CGPoint(x: 0.27489*width, y: 0.25222*height), control1: CGPoint(x: 0.27701*width, y: 0.22095*height), control2: CGPoint(x: 0.27655*width, y: 0.23672*height))
//        path.addCurve(to: CGPoint(x: 0.26899*width, y: 0.28721*height), control1: CGPoint(x: 0.27368*width, y: 0.26351*height), control2: CGPoint(x: 0.27206*width, y: 0.27665*height))
//        path.addCurve(to: CGPoint(x: 0.26713*width, y: 0.27484*height), control1: CGPoint(x: 0.26736*width, y: 0.29278*height), control2: CGPoint(x: 0.26719*width, y: 0.27628*height))
//        path.addCurve(to: CGPoint(x: 0.26819*width, y: 0.24455*height), control1: CGPoint(x: 0.2668*width, y: 0.26608*height), control2: CGPoint(x: 0.26544*width, y: 0.25281*height))
//        path.addCurve(to: CGPoint(x: 0.27807*width, y: 0.23728*height), control1: CGPoint(x: 0.26989*width, y: 0.23945*height), control2: CGPoint(x: 0.27478*width, y: 0.23858*height))
//        path.addCurve(to: CGPoint(x: 0.3255*width, y: 0.22776*height), control1: CGPoint(x: 0.29367*width, y: 0.2311*height), control2: CGPoint(x: 0.30957*width, y: 0.23157*height))
//        path.addCurve(to: CGPoint(x: 0.34631*width, y: 0.19615*height), control1: CGPoint(x: 0.33489*width, y: 0.22551*height), control2: CGPoint(x: 0.3504*width, y: 0.21489*height))
//        path.addCurve(to: CGPoint(x: 0.32427*width, y: 0.19178*height), control1: CGPoint(x: 0.34343*width, y: 0.18296*height), control2: CGPoint(x: 0.32998*width, y: 0.18653*height))
//        path.addCurve(to: CGPoint(x: 0.3173*width, y: 0.20521*height), control1: CGPoint(x: 0.32043*width, y: 0.19532*height), control2: CGPoint(x: 0.3187*width, y: 0.19871*height))
//        path.addCurve(to: CGPoint(x: 0.31342*width, y: 0.27339*height), control1: CGPoint(x: 0.31256*width, y: 0.22721*height), control2: CGPoint(x: 0.30979*width, y: 0.25012*height))
//        path.addCurve(to: CGPoint(x: 0.31889*width, y: 0.29111*height), control1: CGPoint(x: 0.31438*width, y: 0.2795*height), control2: CGPoint(x: 0.31545*width, y: 0.28703*height))
//        path.addCurve(to: CGPoint(x: 0.34697*width, y: 0.29792*height), control1: CGPoint(x: 0.32622*width, y: 0.29978*height), control2: CGPoint(x: 0.33826*width, y: 0.29823*height))
//        path.addCurve(to: CGPoint(x: 0.37285*width, y: 0.27643*height), control1: CGPoint(x: 0.35826*width, y: 0.29752*height), control2: CGPoint(x: 0.36663*width, y: 0.29084*height))
//        path.addCurve(to: CGPoint(x: 0.39776*width, y: 0.21499*height), control1: CGPoint(x: 0.38157*width, y: 0.25622*height), control2: CGPoint(x: 0.38815*width, y: 0.2344*height))
//        path.addCurve(to: CGPoint(x: 0.409*width, y: 0.18901*height), control1: CGPoint(x: 0.40198*width, y: 0.20648*height), control2: CGPoint(x: 0.40663*width, y: 0.19911*height))
//        path.addCurve(to: CGPoint(x: 0.41297*width, y: 0.18874*height), control1: CGPoint(x: 0.41033*width, y: 0.18335*height), control2: CGPoint(x: 0.41075*width, y: 0.18446*height))
//        path.addCurve(to: CGPoint(x: 0.41059*width, y: 0.2427*height), control1: CGPoint(x: 0.41881*width, y: 0.20001*height), control2: CGPoint(x: 0.42364*width, y: 0.23774*height))
//        path.addCurve(to: CGPoint(x: 0.39393*width, y: 0.23635*height), control1: CGPoint(x: 0.40418*width, y: 0.24514*height), control2: CGPoint(x: 0.39938*width, y: 0.24045*height))
//        path.addCurve(to: CGPoint(x: 0.40265*width, y: 0.24442*height), control1: CGPoint(x: 0.39087*width, y: 0.23406*height), control2: CGPoint(x: 0.39939*width, y: 0.24288*height))
//        path.addCurve(to: CGPoint(x: 0.43201*width, y: 0.21916*height), control1: CGPoint(x: 0.41611*width, y: 0.25078*height), control2: CGPoint(x: 0.4261*width, y: 0.23601*height))
//        path.addCurve(to: CGPoint(x: 0.44868*width, y: 0.1443*height), control1: CGPoint(x: 0.44015*width, y: 0.19597*height), control2: CGPoint(x: 0.44534*width, y: 0.16991*height))
//        path.addCurve(to: CGPoint(x: 0.45582*width, y: 0.04848*height), control1: CGPoint(x: 0.45282*width, y: 0.1125*height), control2: CGPoint(x: 0.45284*width, y: 0.08042*height))
//        path.addCurve(to: CGPoint(x: 0.46138*width, y: 0.01615*height), control1: CGPoint(x: 0.4569*width, y: 0.03696*height), control2: CGPoint(x: 0.45852*width, y: 0.02687*height))
//        path.addCurve(to: CGPoint(x: 0.46217*width, y: 0.01324*height), control1: CGPoint(x: 0.46171*width, y: 0.01488*height), control2: CGPoint(x: 0.46217*width, y: 0.00966*height))
//        path.addCurve(to: CGPoint(x: 0.46217*width, y: 0.08545*height), control1: CGPoint(x: 0.46217*width, y: 0.03731*height), control2: CGPoint(x: 0.46217*width, y: 0.06138*height))
//        path.addCurve(to: CGPoint(x: 0.45886*width, y: 0.20673*height), control1: CGPoint(x: 0.46217*width, y: 0.12564*height), control2: CGPoint(x: 0.46406*width, y: 0.16707*height))
//        path.addCurve(to: CGPoint(x: 0.4463*width, y: 0.29098*height), control1: CGPoint(x: 0.45516*width, y: 0.23499*height), control2: CGPoint(x: 0.4498*width, y: 0.26261*height))
//        path.addCurve(to: CGPoint(x: 0.4396*width, y: 0.32926*height), control1: CGPoint(x: 0.4447*width, y: 0.30391*height), control2: CGPoint(x: 0.44292*width, y: 0.31704*height))
//        path.addCurve(to: CGPoint(x: 0.43598*width, y: 0.32153*height), control1: CGPoint(x: 0.43752*width, y: 0.33692*height), control2: CGPoint(x: 0.43621*width, y: 0.32377*height))
//        path.addCurve(to: CGPoint(x: 0.43691*width, y: 0.27894*height), control1: CGPoint(x: 0.43462*width, y: 0.30783*height), control2: CGPoint(x: 0.43442*width, y: 0.29237*height))
//        path.addCurve(to: CGPoint(x: 0.46023*width, y: 0.21823*height), control1: CGPoint(x: 0.44113*width, y: 0.25611*height), control2: CGPoint(x: 0.44972*width, y: 0.23562*height))
//        path.addCurve(to: CGPoint(x: 0.49232*width, y: 0.23728*height), control1: CGPoint(x: 0.47236*width, y: 0.19815*height), control2: CGPoint(x: 0.49325*width, y: 0.2109*height))
//        path.addCurve(to: CGPoint(x: 0.49153*width, y: 0.26254*height), control1: CGPoint(x: 0.49203*width, y: 0.24567*height), control2: CGPoint(x: 0.4914*width, y: 0.25398*height))
//        path.addCurve(to: CGPoint(x: 0.50599*width, y: 0.2882*height), control1: CGPoint(x: 0.49173*width, y: 0.27603*height), control2: CGPoint(x: 0.49811*width, y: 0.28329*height))
//        path.addCurve(to: CGPoint(x: 0.53676*width, y: 0.28489*height), control1: CGPoint(x: 0.5163*width, y: 0.29463*height), control2: CGPoint(x: 0.52664*width, y: 0.29014*height))
//        path.addCurve(to: CGPoint(x: 0.54827*width, y: 0.26763*height), control1: CGPoint(x: 0.54313*width, y: 0.28159*height), control2: CGPoint(x: 0.54396*width, y: 0.2741*height))
//        path.addCurve(to: CGPoint(x: 0.55527*width, y: 0.26763*height), control1: CGPoint(x: 0.55069*width, y: 0.26399*height), control2: CGPoint(x: 0.55198*width, y: 0.2694*height))
//        path.addCurve(to: CGPoint(x: 0.89324*width, y: 0.26802*height), control1: CGPoint(x: 0.55768*width, y: 0.26634*height), control2: CGPoint(x: 0.85899*width, y: 0.26802*height))
//        path.addCurve(to: CGPoint(x: 0.98968*width, y: 0.40863*height), control1: CGPoint(x: 0.92749*width, y: 0.26802*height), control2: CGPoint(x: 0.98668*width, y: 0.29641*height))
//        path.addCurve(to: CGPoint(x: 0.98998*width, y: 0.99118*height), control1: CGPoint(x: 0.99506*width, y: 0.52477*height), control2: CGPoint(x: 0.99147*width, y: 0.69712*height))
//        return path
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

// A ScrollView wrapper that tracks scroll offset changes. Found it on SO, but lost the url
struct ObservableScrollView<Content>: View where Content : View {
    @Namespace var scrollSpace
    
    @Binding var scrollOffset: CGFloat
    let content: (ScrollViewProxy) -> Content
    
    init(scrollOffset: Binding<CGFloat>,
         @ViewBuilder content: @escaping (ScrollViewProxy) -> Content) {
        _scrollOffset = scrollOffset
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                content(proxy)
                    .background(GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).minY
                        Color.clear
                            .preference(key: ScrollViewOffsetPreferenceKey.self,
                                        value: offset)
                    })
            }
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }
}

extension FloatingPoint {
    func mapped(from source: (Self, Self), to target: (Self, Self)) -> Self {
        (self - source.0) / (source.1 - source.0) * (target.1 - target.0) + target.0
    }
    
    func mapped(to: (Self, Self)) -> Self {
        self.mapped(from: (0,1), to: (to.0, to.1))
    }
}
