//
//  YogaPose.swift
//  Stress_Relief_App
//
//  Created by Aditya Rai on 18/02/25.
//

let poseImages = [
    ("Mountain Pose (Tadasana)","mountain_pose"),
    ("Downward Dog (Adho Mukha Svanasana)","downward_dog"),
    ("Child’s Pose (Balasana)","child_pose"),
    ("Standing Forward Bend (Uttanasana)","Standing_Forward_Bend")
]

let poseSteps = [
    ("Mountain Pose (Tadasana)", [
        "Stand tall with your feet together and weight evenly distributed.",
        "Engage your legs and lengthen your spine, keeping your chest open.",
        "Relax your shoulders and let your arms hang naturally with palms facing forward.",
        "Draw in your core and keep your pelvis neutral.",
        "Focus your gaze ahead and breathe deeply."
    ]),
    
    ("Downward Dog (Adho Mukha Svanasana)", [
        "Start on hands and knees, with wrists aligned under your shoulders and knees under your hips.",
        "Lift your hips towards the ceiling, forming an inverted V shape with your body.",
        "Press your hands into the mat, keep your fingers spread, and straighten your legs.",
        "Keep your head between your arms, with your gaze directed towards your legs.",
        "Breathe deeply and hold the pose."
    ]),
    
    ("Child’s Pose (Balasana)", [
        "Start on your knees, with your big toes touching and knees apart.",
        "Lower your torso toward the ground, resting your forehead on the mat.",
        "Extend your arms forward, or let them rest by your sides.",
        "Relax your body and breathe deeply to calm your nervous system."
    ]),
    
    ("Standing Forward Bend (Uttanasana)", [
        "Stand tall with feet hip-width apart, and bend forward from the hips.",
        "Keep your legs straight, but with a slight bend in your knees if necessary.",
        "Place your hands on the floor or your legs, keeping your torso relaxed.",
        "Let your head hang and focus on your breath as you deepen the stretch."
    ])
]


func getPoseSteps(for poseName: String) -> [String] {
    return poseSteps.first { $0.0 == poseName }?.1 ?? []
}
