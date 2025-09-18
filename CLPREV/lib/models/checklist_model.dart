class ChecklistModel {
  String companyName;
  DateTime visitDate;
  String position;
  String evaluator;
  String companion;
  String rgf;

  // Descrição do ambiente
  String local;
  String structure;
  String area;
  String ceilingHeight;
  String floor;
  String coverage;
  String ventilation;
  String windows;
  String lighting;

  // Avaliação ambiental
  String department;
  String exposedFunctions;
  int exposedEmployees;

  // Riscos
  List<Risk> risks;

  // Trabalhos especiais
  bool heightWork;
  bool confinedSpace;
  String observations;

  // Assinaturas
  String technicianSignaturePath;
  String companionSignaturePath;

  ChecklistModel({
    this.companyName = '',
    DateTime? visitDate,
    this.position = '',
    this.evaluator = '',
    this.companion = '',
    this.rgf = '',
    this.local = '',
    this.structure = '',
    this.area = '',
    this.ceilingHeight = '',
    this.floor = '',
    this.coverage = '',
    this.ventilation = '',
    this.windows = '',
    this.lighting = '',
    this.department = '',
    this.exposedFunctions = '',
    this.exposedEmployees = 0,
    List<Risk>? risks,
    this.heightWork = false,
    this.confinedSpace = false,
    this.observations = '',
    this.technicianSignaturePath = '',
    this.companionSignaturePath = '',
  }) : visitDate = visitDate ?? DateTime.now(),
        risks = risks ?? [Risk()];
}

class Risk {
  String type;
  String agent;
  String concentration;
  String source;
  String frequency;
  String severity;
  String probability;
  String epi;

  Risk({
    this.type = '',
    this.agent = '',
    this.concentration = '',
    this.source = '',
    this.frequency = '',
    this.severity = '',
    this.probability = '',
    this.epi = '',
  });
}