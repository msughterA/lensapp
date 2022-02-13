import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// class to hold camera modes for different subjects
class Mode {
  final String mode;
  final String description;
  Mode({this.mode, this.description});
}

// class to hold subject tile models
class SubjectModel {
  final String subjectName;
  final Icon icon;
  final Color color;
  final List<Mode> modes;
  SubjectModel({this.color, this.icon, this.modes, this.subjectName});
}

// Make Camera modes for each and every subject maths, physics, biology, chemistry

// biology
List<Mode> biologyModes = [
  Mode(
      mode: 'Auto',
      description: 'automatically figure out how to biology question'),
  Mode(
      mode: 'Examples',
      description: 'gives you examples to questions in biology'),
  Mode(
      mode: 'Objective',
      description: 'gives you answers to objective question in biology'),
];

// chemistry
List<Mode> chemistryModes = [
  Mode(
      mode: 'Auto',
      description: 'automatically figure out how to chemistry question'),
  //Mode(mode: 'Balance', description: 'Balance chemical equations'),
  //Mode(
  //    mode: 'Objective',
  //    description: 'gives you answers to objective question in chemistry'),
  //Mode(
  //    mode: 'Examples',
  //    description: 'gives you examples to questions in chemistry'),
];

// Mathematics
List<Mode> mathematicsModes = [
  Mode(
      mode: 'Auto',
      description: 'automatically figure out how to maths question'),
  //Mode(mode: 'Solve', description: 'Solves mathematical equations'),
  //Mode(mode: 'Simplify', description: 'Simplifies mathematical equations'),
  //Mode(mode: 'Prove', description: 'Prove mathematical Theorems'),
  //Mode(mode: 'Integrate', description: 'integerates Mathematical Equations'),
  //Mode(
  //    mode: 'Examples',
  //   description: 'gives you examples to questions in mathematics'),
];

// Physics
List<Mode> physicsModes = [
  Mode(
      mode: 'Auto',
      description: 'automatically figure out how to answer physics question'),
  Mode(mode: 'Unit', description: 'Converting numerical units in physics'),
  Mode(
      mode: 'Examples',
      description: 'gives you examples to questions in mathematics'),
];

// Examples
List<Mode> exampleModes = [
  Mode(
      description:
          'Give you sample guides on how to answer a Mathematics question',
      mode: 'Mathematics'),
];

// Summary
List<Mode> summarizeModes = [
  Mode(
      mode: 'summarize',
      description: 'summarizes complex paragraphs in a way you can understand'),
];

List<SubjectModel> subjectModels = [
  // Mathematics
  SubjectModel(
      color: Colors.redAccent,
      icon: Icon(
        Icons.calculate_outlined,
        color: Colors.black,
        size: 5.0.h,
      ),
      modes: mathematicsModes,
      subjectName: 'Mathematics'),
// Summarizer
  SubjectModel(
      color: Colors.orangeAccent,
      icon: Icon(
        Icons.summarize_outlined,
        color: Colors.black,
        size: 5.0.h,
      ),
      modes: summarizeModes,
      subjectName: 'Summarizer'),
  // Examples
  SubjectModel(
      color: Colors.blueAccent,
      icon: Icon(
        Icons.stream_outlined,
        color: Colors.black,
        size: 5.0.h,
      ),
      modes: exampleModes,
      subjectName: 'Examples'),
  // Chemistry
  SubjectModel(
      color: Colors.deepPurple,
      icon: Icon(
        Icons.biotech_outlined,
        color: Colors.black,
        size: 5.0.h,
      ),
      modes: chemistryModes,
      subjectName: 'Chemistry')
];

List<SubjectModel> FutureSubjectModels = [
  // Mathematics
  SubjectModel(
      color: Colors.redAccent,
      icon: Icon(
        Icons.calculate_outlined,
        color: Colors.black,
        size: 5.0.h,
      ),
      modes: mathematicsModes,
      subjectName: 'Mathematics'),
// Summarizer
  SubjectModel(
      color: Colors.orangeAccent,
      icon: Icon(
        Icons.summarize_outlined,
        color: Colors.black,
        size: 5.0.h,
      ),
      modes: summarizeModes,
      subjectName: 'Summarizer'),
  // Biology
  SubjectModel(
      color: Colors.blueAccent,
      icon: Icon(
        Icons.biotech_outlined,
        color: Colors.black,
        size: 5.0.h,
      ),
      modes: biologyModes,
      subjectName: 'Biology'),
// Physics
  SubjectModel(
      color: Colors.yellowAccent,
      icon: Icon(
        Icons.electric_car_outlined,
        color: Colors.black,
        size: 5.0.h,
      ),
      modes: physicsModes,
      subjectName: 'Physics'),
  // Chemistry
  SubjectModel(
      color: Colors.purpleAccent,
      icon: Icon(
        Icons.biotech_outlined,
        color: Colors.black,
        size: 5.0.h,
      ),
      modes: chemistryModes,
      subjectName: 'Chemistry')
];
