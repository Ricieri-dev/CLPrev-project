class ChecklistModel{
  String companyName;
  DateTime visitDate;
  String position;
  String evaluator;
  String companion;
  String rgf;

  //descrição do ambiente
  String local;
  String structure;
  String area;
  String ceilingHeight;
  String floor;
  String coverage;
  String ventilation;
  String windows;
  String lighting;

  //avaliação ambiental
  String department;
  String exposedFunctions;
  int exposedEmployees;

  //riscos
  List<Risk> risks;

  //trabalhos especiais
  bool heightWork;
  bool confinedSpace;
  String observations;

  //assinaturas
  String technicianSignaturePath;
  String companionSignaturePath;


  ChecklistModel({
    this.companyName = '',
    DateTime? visitDate,
    this.position = '',
    this.evaluator = '',
    this.companion = '',
    this.rgf  = '',
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
    List<Risk> ? risks,
    this.heightWork = false,
    this.confinedSpace = false,
    this.observations = '',
    this.technicianSignaturePath = '',
    this.companionSignaturePath = ''
  }) : visitDate = visitDate ?? DateTime.now(),
       risks = risks ?? [Risk()];



  }

class Risk{
  String type;
  String agent;
  String concentration;
  String source;
  String frequency;
  String severety;
  String probability;
  String epi;

  Risk({
    this.type = '',
    this.agent = '',
    this.concentration = '',
    this.source = '',
    this.frequency = '',
    this.severety = '',
    this.probability = '',
    this.epi = '',

});





}