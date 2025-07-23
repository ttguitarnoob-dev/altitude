//
//  BackgroundView.swift
//  Altytude
//
//  Created by Travis Thompson on 7/23/25.
//

import SwiftUI

struct MovingSymbol: Identifiable {
    let id = UUID()
    var symbol: String
    var color: Color
    var position: CGPoint
    var velocity: CGVector
    var angle: Double
    var angularVelocity: Double
}

struct BackgroundView: View {
    @State private var symbols: [MovingSymbol] = []
    @State private var timer: Timer? = nil
    @State private var screenSize: CGSize = .zero
    
    let possibleSymbols = [
        "mountain.2.fill", "mountain.2"
    ]
    
    let possibleColors: [Color] = [
        Color.green.opacity(0.5), Color.blue.opacity(0.5), Color.brown.opacity(0.5),
        Color.cyan.opacity(0.5), Color.mint.opacity(0.5), Color.yellow.opacity(0.45),
        
    ]
    
    let symbolCount = Int.random(in: 8...10)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear.ignoresSafeArea()
                ForEach(symbols) { symbol in
                    Image(systemName: symbol.symbol)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .foregroundStyle(symbol.color)
                        .rotationEffect(.degrees(symbol.angle))
                        .position(symbol.position)
                        .shadow(color: symbol.color.opacity(0.5), radius: 8)
                        .animation(.linear(duration: 0.015), value: symbol.position)
                }
            }
            .onAppear {
                self.screenSize = geo.size
                if symbols.isEmpty {
                    self.symbols = createRandomSymbols(in: geo.size)
                }
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
        }
    }
    
    func createRandomSymbols(in size: CGSize) -> [MovingSymbol] {
        (0..<symbolCount).map { _ in
            let symbolName = possibleSymbols.randomElement() ?? "leaf.fill"
            let color = possibleColors.randomElement() ?? Color.green.opacity(0.5)
            let x = CGFloat.random(in: 60...(size.width - 60))
            let y = CGFloat.random(in: 60...(size.height - 60))
            let dx = CGFloat.random(in: -0.15...0.15)
            let dy = CGFloat.random(in: -0.15...0.15)
            let angle = Double.random(in: 0...360)
            let angularVelocity = Double.random(in: -0.25...0.25)
            return MovingSymbol(
                symbol: symbolName,
                color: color,
                position: CGPoint(x: x, y: y),
                velocity: CGVector(dx: dx, dy: dy),
                angle: angle,
                angularVelocity: angularVelocity
            )
        }
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            updateSymbols()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateSymbols() {
        guard !symbols.isEmpty else { return }
        let width = screenSize.width
        let height = screenSize.height

        symbols = symbols.map { symbol in
            var pos = symbol.position
            var vel = symbol.velocity
            let size: CGFloat = 60
            
            pos.x += vel.dx
            pos.y += vel.dy
            
            // Bounce off left/right edges
            if pos.x - size/2 < 0 {
                pos.x = size/2
                vel.dx = abs(vel.dx)
            } else if pos.x + size/2 > width {
                pos.x = width - size/2
                vel.dx = -abs(vel.dx)
            }
            // Bounce off top/bottom edges
            if pos.y - size/2 < 0 {
                pos.y = size/2
                vel.dy = abs(vel.dy)
            } else if pos.y + size/2 > height {
                pos.y = height - size/2
                vel.dy = -abs(vel.dy)
            }
            
            var angle = symbol.angle + symbol.angularVelocity
            if angle > 360 { angle -= 360 }
            if angle < 0 { angle += 360 }
            
            return MovingSymbol(
                symbol: symbol.symbol,
                color: symbol.color,
                position: pos,
                velocity: vel,
                angle: angle,
                angularVelocity: symbol.angularVelocity
            )
        }
    }
}

#Preview {
    BackgroundView()
}
