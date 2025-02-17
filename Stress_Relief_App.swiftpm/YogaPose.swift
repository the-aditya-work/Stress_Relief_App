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
    ("Warrior II (Virabhadrasana II)","warrior_ii"),
    ("Legs Up the Wall (Viparita Karani)","Legs_Up_the_Wall"),
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

    ("Warrior II (Virabhadrasana II)", [
        "Stand with your feet wide apart, arms extended to the sides at shoulder height.",
        "Turn your right foot out 90 degrees and bend your right knee, keeping your left leg straight.",
        "Ensure your left foot is grounded and your hips are squared.",
        "Keep your shoulders relaxed and gaze over your right hand.",
        "Hold the position and breathe deeply, maintaining focus."
    ]),

    ("Legs Up the Wall (Viparita Karani)", [
        "Sit with one hip touching a wall and then swing your legs up the wall as you lie on your back.",
        "Adjust your position so your legs are straight up against the wall, with your feet relaxed.",
        "Place your arms by your sides, palms facing up.",
        "Close your eyes, relax your body, and breathe deeply."
    ]),

    ("Standing Forward Bend (Uttanasana)", [
        "Stand tall with feet hip-width apart, and bend forward from the hips.",
        "Keep your legs straight, but with a slight bend in your knees if necessary.",
        "Place your hands on the floor or your legs, keeping your torso relaxed.",
        "Let your head hang and focus on your breath as you deepen the stretch."
    ])
]

// Helper function to get pose steps based on pose name
func getPoseSteps(for poseName: String) -> [String] {
    return poseSteps.first { $0.0 == poseName }?.1 ?? []
}
