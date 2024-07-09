//
//  ChallengeView.swift
//  Gym.io
//
//  Created by Matheus Jorge on 7/6/24.
//

import SwiftUI

struct ChallengeView: View {
    @State var challenge: Challenge
    @State var isPresentingWorkoutForm = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Details
                Text(challenge.description)
                    .font(.body)
                
                // Participants/Ranking
                VStack(alignment: .leading, spacing: 8) {
                    Text("Participants")
                        .font(.headline)
                    
                    ForEach(challenge.ranking, id: \.id) { user in
                        HStack {
                            Text(user.name)
                                .font(.body)
                            Spacer()
                            Text("\(challenge.calculatePoints(for: user)) pts")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                        Divider()
                    }
                }
                
                // Dates
                VStack(alignment: .leading, spacing: 8) {
                    Text("Start Date:")
                        .font(.headline)
                    Text(challenge.startDate, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("End Date:")
                        .font(.headline)
                    Text(challenge.endDate, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Point System
                VStack(alignment: .leading, spacing: 8) {
                    Text("Point System:")
                        .font(.headline)
                    Text("Points per 100 kg -> \(challenge.rules.pointsPerHundredKgs)")
                        .font(.subheadline)
                    Text("Points per 100 reps -> \(challenge.rules.pointsPerHundredReps)")
                        .font(.subheadline)
                    Text("Points per hour -> \(challenge.rules.pointsPerHour)")
                        .font(.subheadline)
                }
                
                
            }
            .padding()
            .sheet(isPresented: $isPresentingWorkoutForm) {
                ChallengeFormView(
                    challenge: challenge,
                    onSave: { newChallenge in
                        challenge = newChallenge
                        isPresentingWorkoutForm = false
                    },
                    onDelete: { challenge in
                        isPresentingWorkoutForm = false
                    }
                )
            }
        }
        .navigationTitle(challenge.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isPresentingWorkoutForm.toggle() }) {
                    Text("Edit")
                    Image(systemName: "pencil")
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(20)
            }
        }
    }
}


#Preview {
    NavigationView {
        ChallengeView(challenge: _previewChallenge)
    }
}

let _previewChallenge = Challenge(
    title: "30-Day Fitness",
    description: "Join us in this 30-day fitness challenge!",
    rules: Rules(pointsPerHundredKgs: 10, pointsPerHundredReps: 5, pointsPerHour: 100),
    startDate: Date().addingTimeInterval(-60 * 60 * 24 * 10),
    endDate: Date().addingTimeInterval(60 * 60 * 24 * 30),
    participants: _previewParticipants
)

let _previewParticipants = [
    User(name:"Matheus Jorge", username: "teujorge", completedWorkouts: _previewWorkoutsCompleted),
    User(name: "Alice", username: "alice"),
    User(name: "Bob", username: "bobby"),
    User(name: "Charlie", username: "ccc", completedWorkouts: _previewWorkoutsCompleted)
]

// map through _previewWorkouts and create a WorkoutCompleted with random date
let _previewWorkoutsCompleted = _previewWorkouts.map { workout in
    WorkoutCompleted(
        date: Date().addingTimeInterval(-Double.random(in: 0...(60 * 60 * 24 * 10))),
        workout: workout
    )
}
