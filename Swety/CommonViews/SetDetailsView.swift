//
//  SetDetailsView.swift
//  Swety
//
//  Created by Matheus Jorge on 7/10/24.
//

import SwiftUI

struct SetDetailsView: View {
    @StateObject var viewModel: SetDetailsViewModel
    
    private var gridItems: [GridItem] {
        viewModel.isPlan
        ? [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        : [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    }
    
    init(
        sets: [SetDetails],
        isPlan: Bool,
        isRepBased: Bool,
        autoSave: Bool,
        onToggleIsRepBased: ((Bool) -> Void)? = nil,
        onSetsChanged: (([SetDetails]) -> Void)? = nil,
        onDebounceTriggered: (() -> Void)? = nil
    ) {
        _viewModel = StateObject(wrappedValue: SetDetailsViewModel(
            sets: sets,
            isPlan: isPlan,
            isRepBased: isRepBased,
            autoSave: autoSave,
            onToggleIsRepBased: onToggleIsRepBased,
            onSetsChanged: onSetsChanged,
            onDebounceTriggered: onDebounceTriggered
        ))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            headerView
            Divider()
//            setsList
            Button(action: viewModel.addSet) {
                HStack {
                    Text("Add set")
                    Image(systemName: "plus.circle")
                        .foregroundColor(.accent)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.accent.opacity(0.2))
                .cornerRadius(.medium)
            }
            .buttonStyle(.plain)
            .padding(.horizontal)
            .transition(.move(edge: .bottom))
        }
        .animation(.easeInOut, value: viewModel.sets.count)
    }
    
//    private var setsList: some View {
//        List($viewModel.sets) { $exerciseSet in
//            LazyVGrid(columns: gridItems, alignment: .center) {
//                Text("\(exerciseSet.index)")
//                if viewModel.isRepBased {
//                    TextField("Reps", value: $exerciseSet.reps, formatter: NumberFormatter())
//                        .multilineTextAlignment(.center)
//                        .keyboardType(.decimalPad)
//                    TextField("Weight", value: $exerciseSet.weight, formatter: NumberFormatter())
//                        .multilineTextAlignment(.center)
//                        .keyboardType(.decimalPad)
//                } else {
//                    TextField("Duration", value: $exerciseSet.duration, formatter: NumberFormatter())
//                        .multilineTextAlignment(.center)
//                        .keyboardType(.decimalPad)
//                    Picker("", selection: $exerciseSet.intensity) {
//                        ForEach(Intensity.allCases, id: \.self) { intensity in
//                            Text(intensity.rawValue.first.map(String.init) ?? "")
//                                .tag(intensity)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
//                if !viewModel.isPlan {
//                    Button(action: { viewModel.toggleSetCompletion(exerciseSet.id) }) {
//                        Image(systemName: exerciseSet.completedAt == nil ? "square" : "checkmark.square")
//                    }
//                    .transition(.opacity)
//                }
//            }
//            .listRowInsets(EdgeInsets(
//                top: viewModel.rowInsets / 2,
//                leading: 0,
//                bottom: viewModel.rowInsets / 2,
//                trailing: 0
//            ))
//            .listRowBackground(exerciseSet.completedAt == nil ? nil : Color.green.opacity(0.7))
//            .animation(.easeInOut, value: exerciseSet.completedAt)
//            .frame(minHeight: viewModel.rowHeight)
//            .swipeActions {
//                Button(role: .destructive, action: {
//                    viewModel.deleteSet(exerciseSet.id)
//                }) {
//                    Label("Delete", systemImage: "trash")
//                }
//            }
//        }
//        .listStyle(.plain)
//        .frame(minHeight: viewModel.listHeight)
//        .cornerRadius(.medium)
//        .padding(0)
//        .background(.clear)
//        .transition(.move(edge: .bottom))
//        .onChange(of: viewModel.sets.count) { oldCount, newCount in
//            withAnimation {
//                viewModel.listHeight = CGFloat(newCount) * (viewModel.rowHeight + viewModel.rowInsets)
//            }
//        }
//    }
    
    private var headerView: some View {
        LazyVGrid(columns: gridItems, alignment: .center) {
            Text("Set")
            if viewModel.isRepBased {
                Text("Reps")
                Text("Kg")
                
            } else {
                Text("Sec")
                Text("Intensity")
            }
            if !viewModel.isPlan {
                Image(systemName: "checkmark")
            }
        }
        .fontWeight(.medium)
    }
}

#Preview {
    NavigationView {
        ScrollView {
            Section {
                SetDetailsView(
                    sets: [],
                    isPlan: true,
                    isRepBased: true,
                    autoSave: false
                )
            }
        }
    }
    .navigationTitle("SetDetailsPreview")
}

