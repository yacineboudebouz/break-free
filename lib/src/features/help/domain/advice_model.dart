class AdviceModel {
  int id;
  String title;
  String description;

  AdviceModel({
    required this.id,
    required this.title,
    required this.description,
  });

  static final advices = <AdviceModel>[
    AdviceModel(
      id: 1,
      title: "Replace, Don't Remove",
      description:
          "Instead of just stopping a habit, replace it with a positive one. If you smoke when stressed, replace it with deep breathing or a 2-minute walk. Your brain needs something to fill the void.",
    ),
    AdviceModel(
      id: 2,
      title: "The 20-20-20 Rule",
      description:
          "When you feel the urge, wait 20 minutes, do 20 jumping jacks, and drink 20 sips of water. Most cravings pass within 15-20 minutes, and physical activity rewires your response.",
    ),
    AdviceModel(
      id: 3,
      title: "Environment Design",
      description:
          "Make bad habits impossible and good habits obvious. Remove triggers from your environment. Hide your phone if you're trying to reduce screen time, or keep healthy snacks visible.",
    ),
    AdviceModel(
      id: 4,
      title: "Track Your 'Why' Moments",
      description:
          "Write down exactly when and why you feel like doing the habit. After a week, you'll see clear patterns. Most people are shocked to discover their real triggers aren't what they thought.",
    ),
    AdviceModel(
      id: 5,
      title: "The Tiny Win Strategy",
      description:
          "Focus on being 1% better each day rather than perfect. If you want to quit social media, start by checking it 1 minute less each day. Small changes compound into massive results.",
    ),
    AdviceModel(
      id: 6,
      title: "Create Friction",
      description:
          "Add steps between you and your bad habit. Want to stop late-night snacking? Put snacks in a locked box. The extra effort gives your rational brain time to kick in.",
    ),
    AdviceModel(
      id: 7,
      title: "The 'If-Then' Planning",
      description:
          "Create specific plans: 'If I feel like scrolling social media, then I'll read one page of a book.' Pre-deciding your response eliminates willpower battles in the moment.",
    ),
    AdviceModel(
      id: 8,
      title: "Stack Good Habits",
      description:
          "Attach new habits to existing ones. 'After I brush my teeth, I'll do 10 push-ups.' This uses existing neural pathways to build new ones more effectively.",
    ),
    AdviceModel(
      id: 9,
      title: "The Reset Ritual",
      description:
          "When you slip up (and you will), have a 5-minute reset ritual. Acknowledge it, forgive yourself, identify what triggered it, and immediately do one small positive action. Momentum matters more than perfection.",
    ),
    AdviceModel(
      id: 10,
      title: "Measure Leading Indicators",
      description:
          "Don't just track if you avoided the habit. Track: sleep quality, stress levels, energy levels. These predict your success better than willpower and give you early warning signs.",
    ),
    AdviceModel(
      id: 11,
      title: "The 2-Day Rule",
      description:
          "Never allow yourself to skip your replacement habit two days in a row. One day off is recovery, two days is forming a new (bad) pattern. This keeps you consistent without perfectionism.",
    ),
    AdviceModel(
      id: 12,
      title: "Identity Shift",
      description:
          "Stop saying 'I'm trying to quit smoking' and start saying 'I'm a non-smoker who occasionally struggles.' Your brain follows your identity. Act like the person you want to become.",
    ),
  ];
}
