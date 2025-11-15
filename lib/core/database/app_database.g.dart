// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EmployersTable extends Employers
    with TableInfo<$EmployersTable, Employer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactMeta =
      const VerificationMeta('contact');
  @override
  late final GeneratedColumn<String> contact = GeneratedColumn<String>(
      'contact', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalCreditLimitMeta =
      const VerificationMeta('totalCreditLimit');
  @override
  late final GeneratedColumn<int> totalCreditLimit = GeneratedColumn<int>(
      'total_credit_limit', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, contact, note, totalCreditLimit, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employers';
  @override
  VerificationContext validateIntegrity(Insertable<Employer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact')) {
      context.handle(_contactMeta,
          contact.isAcceptableOrUnknown(data['contact']!, _contactMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('total_credit_limit')) {
      context.handle(
          _totalCreditLimitMeta,
          totalCreditLimit.isAcceptableOrUnknown(
              data['total_credit_limit']!, _totalCreditLimitMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      contact: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      totalCreditLimit: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_credit_limit'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $EmployersTable createAlias(String alias) {
    return $EmployersTable(attachedDatabase, alias);
  }
}

class Employer extends DataClass implements Insertable<Employer> {
  final int id;
  final String name;
  final String? contact;
  final String? note;
  final int totalCreditLimit;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Employer(
      {required this.id,
      required this.name,
      this.contact,
      this.note,
      required this.totalCreditLimit,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || contact != null) {
      map['contact'] = Variable<String>(contact);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['total_credit_limit'] = Variable<int>(totalCreditLimit);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  EmployersCompanion toCompanion(bool nullToAbsent) {
    return EmployersCompanion(
      id: Value(id),
      name: Value(name),
      contact: contact == null && nullToAbsent
          ? const Value.absent()
          : Value(contact),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      totalCreditLimit: Value(totalCreditLimit),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Employer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      contact: serializer.fromJson<String?>(json['contact']),
      note: serializer.fromJson<String?>(json['note']),
      totalCreditLimit: serializer.fromJson<int>(json['totalCreditLimit']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'contact': serializer.toJson<String?>(contact),
      'note': serializer.toJson<String?>(note),
      'totalCreditLimit': serializer.toJson<int>(totalCreditLimit),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Employer copyWith(
          {int? id,
          String? name,
          Value<String?> contact = const Value.absent(),
          Value<String?> note = const Value.absent(),
          int? totalCreditLimit,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Employer(
        id: id ?? this.id,
        name: name ?? this.name,
        contact: contact.present ? contact.value : this.contact,
        note: note.present ? note.value : this.note,
        totalCreditLimit: totalCreditLimit ?? this.totalCreditLimit,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Employer copyWithCompanion(EmployersCompanion data) {
    return Employer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      contact: data.contact.present ? data.contact.value : this.contact,
      note: data.note.present ? data.note.value : this.note,
      totalCreditLimit: data.totalCreditLimit.present
          ? data.totalCreditLimit.value
          : this.totalCreditLimit,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contact: $contact, ')
          ..write('note: $note, ')
          ..write('totalCreditLimit: $totalCreditLimit, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, contact, note, totalCreditLimit, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employer &&
          other.id == this.id &&
          other.name == this.name &&
          other.contact == this.contact &&
          other.note == this.note &&
          other.totalCreditLimit == this.totalCreditLimit &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EmployersCompanion extends UpdateCompanion<Employer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> contact;
  final Value<String?> note;
  final Value<int> totalCreditLimit;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const EmployersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.contact = const Value.absent(),
    this.note = const Value.absent(),
    this.totalCreditLimit = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EmployersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.contact = const Value.absent(),
    this.note = const Value.absent(),
    this.totalCreditLimit = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Employer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? contact,
    Expression<String>? note,
    Expression<int>? totalCreditLimit,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (contact != null) 'contact': contact,
      if (note != null) 'note': note,
      if (totalCreditLimit != null) 'total_credit_limit': totalCreditLimit,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EmployersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? contact,
      Value<String?>? note,
      Value<int>? totalCreditLimit,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return EmployersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      note: note ?? this.note,
      totalCreditLimit: totalCreditLimit ?? this.totalCreditLimit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contact.present) {
      map['contact'] = Variable<String>(contact.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (totalCreditLimit.present) {
      map['total_credit_limit'] = Variable<int>(totalCreditLimit.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contact: $contact, ')
          ..write('note: $note, ')
          ..write('totalCreditLimit: $totalCreditLimit, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _employerIdMeta =
      const VerificationMeta('employerId');
  @override
  late final GeneratedColumn<int> employerId = GeneratedColumn<int>(
      'employer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employers (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _budgetMeta = const VerificationMeta('budget');
  @override
  late final GeneratedColumn<int> budget = GeneratedColumn<int>(
      'budget', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, employerId, title, startDate, endDate, status, budget, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employer_id')) {
      context.handle(
          _employerIdMeta,
          employerId.isAcceptableOrUnknown(
              data['employer_id']!, _employerIdMeta));
    } else if (isInserting) {
      context.missing(_employerIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('budget')) {
      context.handle(_budgetMeta,
          budget.isAcceptableOrUnknown(data['budget']!, _budgetMeta));
    } else if (isInserting) {
      context.missing(_budgetMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      employerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}employer_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      budget: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}budget'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final int id;
  final int employerId;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final String status;
  final int budget;
  final String? description;
  const Project(
      {required this.id,
      required this.employerId,
      required this.title,
      required this.startDate,
      this.endDate,
      required this.status,
      required this.budget,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['employer_id'] = Variable<int>(employerId);
    map['title'] = Variable<String>(title);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['status'] = Variable<String>(status);
    map['budget'] = Variable<int>(budget);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      employerId: Value(employerId),
      title: Value(title),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      status: Value(status),
      budget: Value(budget),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<int>(json['id']),
      employerId: serializer.fromJson<int>(json['employerId']),
      title: serializer.fromJson<String>(json['title']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      status: serializer.fromJson<String>(json['status']),
      budget: serializer.fromJson<int>(json['budget']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employerId': serializer.toJson<int>(employerId),
      'title': serializer.toJson<String>(title),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'status': serializer.toJson<String>(status),
      'budget': serializer.toJson<int>(budget),
      'description': serializer.toJson<String?>(description),
    };
  }

  Project copyWith(
          {int? id,
          int? employerId,
          String? title,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          String? status,
          int? budget,
          Value<String?> description = const Value.absent()}) =>
      Project(
        id: id ?? this.id,
        employerId: employerId ?? this.employerId,
        title: title ?? this.title,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        status: status ?? this.status,
        budget: budget ?? this.budget,
        description: description.present ? description.value : this.description,
      );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      employerId:
          data.employerId.present ? data.employerId.value : this.employerId,
      title: data.title.present ? data.title.value : this.title,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      status: data.status.present ? data.status.value : this.status,
      budget: data.budget.present ? data.budget.value : this.budget,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('employerId: $employerId, ')
          ..write('title: $title, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('budget: $budget, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, employerId, title, startDate, endDate, status, budget, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.employerId == this.employerId &&
          other.title == this.title &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.status == this.status &&
          other.budget == this.budget &&
          other.description == this.description);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> id;
  final Value<int> employerId;
  final Value<String> title;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<String> status;
  final Value<int> budget;
  final Value<String?> description;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.employerId = const Value.absent(),
    this.title = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.budget = const Value.absent(),
    this.description = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    required int employerId,
    required String title,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required String status,
    required int budget,
    this.description = const Value.absent(),
  })  : employerId = Value(employerId),
        title = Value(title),
        startDate = Value(startDate),
        status = Value(status),
        budget = Value(budget);
  static Insertable<Project> custom({
    Expression<int>? id,
    Expression<int>? employerId,
    Expression<String>? title,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? status,
    Expression<int>? budget,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employerId != null) 'employer_id': employerId,
      if (title != null) 'title': title,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (status != null) 'status': status,
      if (budget != null) 'budget': budget,
      if (description != null) 'description': description,
    });
  }

  ProjectsCompanion copyWith(
      {Value<int>? id,
      Value<int>? employerId,
      Value<String>? title,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<String>? status,
      Value<int>? budget,
      Value<String?>? description}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      employerId: employerId ?? this.employerId,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      budget: budget ?? this.budget,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employerId.present) {
      map['employer_id'] = Variable<int>(employerId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (budget.present) {
      map['budget'] = Variable<int>(budget.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('employerId: $employerId, ')
          ..write('title: $title, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('budget: $budget, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $IncomeExpenseTable extends IncomeExpense
    with TableInfo<$IncomeExpenseTable, IncomeExpenseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomeExpenseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
      'project_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES projects (id)'));
  static const VerificationMeta _employerIdMeta =
      const VerificationMeta('employerId');
  @override
  late final GeneratedColumn<int> employerId = GeneratedColumn<int>(
      'employer_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employers (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _txDateMeta = const VerificationMeta('txDate');
  @override
  late final GeneratedColumn<DateTime> txDate = GeneratedColumn<DateTime>(
      'tx_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectId, employerId, type, category, amount, description, txDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'income_expense';
  @override
  VerificationContext validateIntegrity(Insertable<IncomeExpenseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    }
    if (data.containsKey('employer_id')) {
      context.handle(
          _employerIdMeta,
          employerId.isAcceptableOrUnknown(
              data['employer_id']!, _employerIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('tx_date')) {
      context.handle(_txDateMeta,
          txDate.isAcceptableOrUnknown(data['tx_date']!, _txDateMeta));
    } else if (isInserting) {
      context.missing(_txDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomeExpenseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeExpenseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project_id']),
      employerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}employer_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      txDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}tx_date'])!,
    );
  }

  @override
  $IncomeExpenseTable createAlias(String alias) {
    return $IncomeExpenseTable(attachedDatabase, alias);
  }
}

class IncomeExpenseData extends DataClass
    implements Insertable<IncomeExpenseData> {
  final int id;
  final int? projectId;
  final int? employerId;
  final String type;
  final String category;
  final int amount;
  final String? description;
  final DateTime txDate;
  const IncomeExpenseData(
      {required this.id,
      this.projectId,
      this.employerId,
      required this.type,
      required this.category,
      required this.amount,
      this.description,
      required this.txDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<int>(projectId);
    }
    if (!nullToAbsent || employerId != null) {
      map['employer_id'] = Variable<int>(employerId);
    }
    map['type'] = Variable<String>(type);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['tx_date'] = Variable<DateTime>(txDate);
    return map;
  }

  IncomeExpenseCompanion toCompanion(bool nullToAbsent) {
    return IncomeExpenseCompanion(
      id: Value(id),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      employerId: employerId == null && nullToAbsent
          ? const Value.absent()
          : Value(employerId),
      type: Value(type),
      category: Value(category),
      amount: Value(amount),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      txDate: Value(txDate),
    );
  }

  factory IncomeExpenseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeExpenseData(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int?>(json['projectId']),
      employerId: serializer.fromJson<int?>(json['employerId']),
      type: serializer.fromJson<String>(json['type']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<int>(json['amount']),
      description: serializer.fromJson<String?>(json['description']),
      txDate: serializer.fromJson<DateTime>(json['txDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int?>(projectId),
      'employerId': serializer.toJson<int?>(employerId),
      'type': serializer.toJson<String>(type),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<int>(amount),
      'description': serializer.toJson<String?>(description),
      'txDate': serializer.toJson<DateTime>(txDate),
    };
  }

  IncomeExpenseData copyWith(
          {int? id,
          Value<int?> projectId = const Value.absent(),
          Value<int?> employerId = const Value.absent(),
          String? type,
          String? category,
          int? amount,
          Value<String?> description = const Value.absent(),
          DateTime? txDate}) =>
      IncomeExpenseData(
        id: id ?? this.id,
        projectId: projectId.present ? projectId.value : this.projectId,
        employerId: employerId.present ? employerId.value : this.employerId,
        type: type ?? this.type,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        description: description.present ? description.value : this.description,
        txDate: txDate ?? this.txDate,
      );
  IncomeExpenseData copyWithCompanion(IncomeExpenseCompanion data) {
    return IncomeExpenseData(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      employerId:
          data.employerId.present ? data.employerId.value : this.employerId,
      type: data.type.present ? data.type.value : this.type,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      description:
          data.description.present ? data.description.value : this.description,
      txDate: data.txDate.present ? data.txDate.value : this.txDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomeExpenseData(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('employerId: $employerId, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('txDate: $txDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, projectId, employerId, type, category, amount, description, txDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeExpenseData &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.employerId == this.employerId &&
          other.type == this.type &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.txDate == this.txDate);
}

class IncomeExpenseCompanion extends UpdateCompanion<IncomeExpenseData> {
  final Value<int> id;
  final Value<int?> projectId;
  final Value<int?> employerId;
  final Value<String> type;
  final Value<String> category;
  final Value<int> amount;
  final Value<String?> description;
  final Value<DateTime> txDate;
  const IncomeExpenseCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.employerId = const Value.absent(),
    this.type = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.txDate = const Value.absent(),
  });
  IncomeExpenseCompanion.insert({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.employerId = const Value.absent(),
    required String type,
    required String category,
    required int amount,
    this.description = const Value.absent(),
    required DateTime txDate,
  })  : type = Value(type),
        category = Value(category),
        amount = Value(amount),
        txDate = Value(txDate);
  static Insertable<IncomeExpenseData> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<int>? employerId,
    Expression<String>? type,
    Expression<String>? category,
    Expression<int>? amount,
    Expression<String>? description,
    Expression<DateTime>? txDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (employerId != null) 'employer_id': employerId,
      if (type != null) 'type': type,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (txDate != null) 'tx_date': txDate,
    });
  }

  IncomeExpenseCompanion copyWith(
      {Value<int>? id,
      Value<int?>? projectId,
      Value<int?>? employerId,
      Value<String>? type,
      Value<String>? category,
      Value<int>? amount,
      Value<String?>? description,
      Value<DateTime>? txDate}) {
    return IncomeExpenseCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      employerId: employerId ?? this.employerId,
      type: type ?? this.type,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      txDate: txDate ?? this.txDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (employerId.present) {
      map['employer_id'] = Variable<int>(employerId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (txDate.present) {
      map['tx_date'] = Variable<DateTime>(txDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomeExpenseCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('employerId: $employerId, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('txDate: $txDate')
          ..write(')'))
        .toString();
  }
}

class $DebtsTable extends Debts with TableInfo<$DebtsTable, Debt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _employerIdMeta =
      const VerificationMeta('employerId');
  @override
  late final GeneratedColumn<int> employerId = GeneratedColumn<int>(
      'employer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employers (id)'));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
      'project_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES projects (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _borrowDateMeta =
      const VerificationMeta('borrowDate');
  @override
  late final GeneratedColumn<DateTime> borrowDate = GeneratedColumn<DateTime>(
      'borrow_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        employerId,
        projectId,
        amount,
        borrowDate,
        dueDate,
        status,
        description,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debts';
  @override
  VerificationContext validateIntegrity(Insertable<Debt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employer_id')) {
      context.handle(
          _employerIdMeta,
          employerId.isAcceptableOrUnknown(
              data['employer_id']!, _employerIdMeta));
    } else if (isInserting) {
      context.missing(_employerIdMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('borrow_date')) {
      context.handle(
          _borrowDateMeta,
          borrowDate.isAcceptableOrUnknown(
              data['borrow_date']!, _borrowDateMeta));
    } else if (isInserting) {
      context.missing(_borrowDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Debt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Debt(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      employerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}employer_id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project_id']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      borrowDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}borrow_date'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
  }
}

class Debt extends DataClass implements Insertable<Debt> {
  final int id;
  final int employerId;
  final int? projectId;
  final int amount;
  final DateTime borrowDate;
  final DateTime dueDate;
  final String status;
  final String? description;
  final DateTime createdAt;
  const Debt(
      {required this.id,
      required this.employerId,
      this.projectId,
      required this.amount,
      required this.borrowDate,
      required this.dueDate,
      required this.status,
      this.description,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['employer_id'] = Variable<int>(employerId);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<int>(projectId);
    }
    map['amount'] = Variable<int>(amount);
    map['borrow_date'] = Variable<DateTime>(borrowDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DebtsCompanion toCompanion(bool nullToAbsent) {
    return DebtsCompanion(
      id: Value(id),
      employerId: Value(employerId),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      amount: Value(amount),
      borrowDate: Value(borrowDate),
      dueDate: Value(dueDate),
      status: Value(status),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory Debt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Debt(
      id: serializer.fromJson<int>(json['id']),
      employerId: serializer.fromJson<int>(json['employerId']),
      projectId: serializer.fromJson<int?>(json['projectId']),
      amount: serializer.fromJson<int>(json['amount']),
      borrowDate: serializer.fromJson<DateTime>(json['borrowDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      status: serializer.fromJson<String>(json['status']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employerId': serializer.toJson<int>(employerId),
      'projectId': serializer.toJson<int?>(projectId),
      'amount': serializer.toJson<int>(amount),
      'borrowDate': serializer.toJson<DateTime>(borrowDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'status': serializer.toJson<String>(status),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Debt copyWith(
          {int? id,
          int? employerId,
          Value<int?> projectId = const Value.absent(),
          int? amount,
          DateTime? borrowDate,
          DateTime? dueDate,
          String? status,
          Value<String?> description = const Value.absent(),
          DateTime? createdAt}) =>
      Debt(
        id: id ?? this.id,
        employerId: employerId ?? this.employerId,
        projectId: projectId.present ? projectId.value : this.projectId,
        amount: amount ?? this.amount,
        borrowDate: borrowDate ?? this.borrowDate,
        dueDate: dueDate ?? this.dueDate,
        status: status ?? this.status,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
      );
  Debt copyWithCompanion(DebtsCompanion data) {
    return Debt(
      id: data.id.present ? data.id.value : this.id,
      employerId:
          data.employerId.present ? data.employerId.value : this.employerId,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      amount: data.amount.present ? data.amount.value : this.amount,
      borrowDate:
          data.borrowDate.present ? data.borrowDate.value : this.borrowDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      status: data.status.present ? data.status.value : this.status,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Debt(')
          ..write('id: $id, ')
          ..write('employerId: $employerId, ')
          ..write('projectId: $projectId, ')
          ..write('amount: $amount, ')
          ..write('borrowDate: $borrowDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, employerId, projectId, amount, borrowDate,
      dueDate, status, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Debt &&
          other.id == this.id &&
          other.employerId == this.employerId &&
          other.projectId == this.projectId &&
          other.amount == this.amount &&
          other.borrowDate == this.borrowDate &&
          other.dueDate == this.dueDate &&
          other.status == this.status &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class DebtsCompanion extends UpdateCompanion<Debt> {
  final Value<int> id;
  final Value<int> employerId;
  final Value<int?> projectId;
  final Value<int> amount;
  final Value<DateTime> borrowDate;
  final Value<DateTime> dueDate;
  final Value<String> status;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  const DebtsCompanion({
    this.id = const Value.absent(),
    this.employerId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.amount = const Value.absent(),
    this.borrowDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DebtsCompanion.insert({
    this.id = const Value.absent(),
    required int employerId,
    this.projectId = const Value.absent(),
    required int amount,
    required DateTime borrowDate,
    required DateTime dueDate,
    this.status = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : employerId = Value(employerId),
        amount = Value(amount),
        borrowDate = Value(borrowDate),
        dueDate = Value(dueDate);
  static Insertable<Debt> custom({
    Expression<int>? id,
    Expression<int>? employerId,
    Expression<int>? projectId,
    Expression<int>? amount,
    Expression<DateTime>? borrowDate,
    Expression<DateTime>? dueDate,
    Expression<String>? status,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employerId != null) 'employer_id': employerId,
      if (projectId != null) 'project_id': projectId,
      if (amount != null) 'amount': amount,
      if (borrowDate != null) 'borrow_date': borrowDate,
      if (dueDate != null) 'due_date': dueDate,
      if (status != null) 'status': status,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DebtsCompanion copyWith(
      {Value<int>? id,
      Value<int>? employerId,
      Value<int?>? projectId,
      Value<int>? amount,
      Value<DateTime>? borrowDate,
      Value<DateTime>? dueDate,
      Value<String>? status,
      Value<String?>? description,
      Value<DateTime>? createdAt}) {
    return DebtsCompanion(
      id: id ?? this.id,
      employerId: employerId ?? this.employerId,
      projectId: projectId ?? this.projectId,
      amount: amount ?? this.amount,
      borrowDate: borrowDate ?? this.borrowDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employerId.present) {
      map['employer_id'] = Variable<int>(employerId.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (borrowDate.present) {
      map['borrow_date'] = Variable<DateTime>(borrowDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtsCompanion(')
          ..write('id: $id, ')
          ..write('employerId: $employerId, ')
          ..write('projectId: $projectId, ')
          ..write('amount: $amount, ')
          ..write('borrowDate: $borrowDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DebtPaymentsTable extends DebtPayments
    with TableInfo<$DebtPaymentsTable, DebtPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _debtIdMeta = const VerificationMeta('debtId');
  @override
  late final GeneratedColumn<int> debtId = GeneratedColumn<int>(
      'debt_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES debts (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paymentDateMeta =
      const VerificationMeta('paymentDate');
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
      'payment_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, debtId, amount, paymentDate, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debt_payments';
  @override
  VerificationContext validateIntegrity(Insertable<DebtPayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('debt_id')) {
      context.handle(_debtIdMeta,
          debtId.isAcceptableOrUnknown(data['debt_id']!, _debtIdMeta));
    } else if (isInserting) {
      context.missing(_debtIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
          _paymentDateMeta,
          paymentDate.isAcceptableOrUnknown(
              data['payment_date']!, _paymentDateMeta));
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DebtPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebtPayment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      debtId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}debt_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      paymentDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}payment_date'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $DebtPaymentsTable createAlias(String alias) {
    return $DebtPaymentsTable(attachedDatabase, alias);
  }
}

class DebtPayment extends DataClass implements Insertable<DebtPayment> {
  final int id;
  final int debtId;
  final int amount;
  final DateTime paymentDate;
  final String? note;
  const DebtPayment(
      {required this.id,
      required this.debtId,
      required this.amount,
      required this.paymentDate,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['debt_id'] = Variable<int>(debtId);
    map['amount'] = Variable<int>(amount);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  DebtPaymentsCompanion toCompanion(bool nullToAbsent) {
    return DebtPaymentsCompanion(
      id: Value(id),
      debtId: Value(debtId),
      amount: Value(amount),
      paymentDate: Value(paymentDate),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory DebtPayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebtPayment(
      id: serializer.fromJson<int>(json['id']),
      debtId: serializer.fromJson<int>(json['debtId']),
      amount: serializer.fromJson<int>(json['amount']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'debtId': serializer.toJson<int>(debtId),
      'amount': serializer.toJson<int>(amount),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'note': serializer.toJson<String?>(note),
    };
  }

  DebtPayment copyWith(
          {int? id,
          int? debtId,
          int? amount,
          DateTime? paymentDate,
          Value<String?> note = const Value.absent()}) =>
      DebtPayment(
        id: id ?? this.id,
        debtId: debtId ?? this.debtId,
        amount: amount ?? this.amount,
        paymentDate: paymentDate ?? this.paymentDate,
        note: note.present ? note.value : this.note,
      );
  DebtPayment copyWithCompanion(DebtPaymentsCompanion data) {
    return DebtPayment(
      id: data.id.present ? data.id.value : this.id,
      debtId: data.debtId.present ? data.debtId.value : this.debtId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentDate:
          data.paymentDate.present ? data.paymentDate.value : this.paymentDate,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DebtPayment(')
          ..write('id: $id, ')
          ..write('debtId: $debtId, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, debtId, amount, paymentDate, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebtPayment &&
          other.id == this.id &&
          other.debtId == this.debtId &&
          other.amount == this.amount &&
          other.paymentDate == this.paymentDate &&
          other.note == this.note);
}

class DebtPaymentsCompanion extends UpdateCompanion<DebtPayment> {
  final Value<int> id;
  final Value<int> debtId;
  final Value<int> amount;
  final Value<DateTime> paymentDate;
  final Value<String?> note;
  const DebtPaymentsCompanion({
    this.id = const Value.absent(),
    this.debtId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.note = const Value.absent(),
  });
  DebtPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int debtId,
    required int amount,
    required DateTime paymentDate,
    this.note = const Value.absent(),
  })  : debtId = Value(debtId),
        amount = Value(amount),
        paymentDate = Value(paymentDate);
  static Insertable<DebtPayment> custom({
    Expression<int>? id,
    Expression<int>? debtId,
    Expression<int>? amount,
    Expression<DateTime>? paymentDate,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (debtId != null) 'debt_id': debtId,
      if (amount != null) 'amount': amount,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (note != null) 'note': note,
    });
  }

  DebtPaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? debtId,
      Value<int>? amount,
      Value<DateTime>? paymentDate,
      Value<String?>? note}) {
    return DebtPaymentsCompanion(
      id: id ?? this.id,
      debtId: debtId ?? this.debtId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (debtId.present) {
      map['debt_id'] = Variable<int>(debtId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('debtId: $debtId, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $WorkersTable extends Workers with TableInfo<$WorkersTable, Worker> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dailyRateMeta =
      const VerificationMeta('dailyRate');
  @override
  late final GeneratedColumn<int> dailyRate = GeneratedColumn<int>(
      'daily_rate', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, fullName, dailyRate, phone, note, active];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workers';
  @override
  VerificationContext validateIntegrity(Insertable<Worker> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('daily_rate')) {
      context.handle(_dailyRateMeta,
          dailyRate.isAcceptableOrUnknown(data['daily_rate']!, _dailyRateMeta));
    } else if (isInserting) {
      context.missing(_dailyRateMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Worker map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Worker(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      dailyRate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}daily_rate'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
    );
  }

  @override
  $WorkersTable createAlias(String alias) {
    return $WorkersTable(attachedDatabase, alias);
  }
}

class Worker extends DataClass implements Insertable<Worker> {
  final int id;
  final String fullName;
  final int dailyRate;
  final String? phone;
  final String? note;
  final bool active;
  const Worker(
      {required this.id,
      required this.fullName,
      required this.dailyRate,
      this.phone,
      this.note,
      required this.active});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['full_name'] = Variable<String>(fullName);
    map['daily_rate'] = Variable<int>(dailyRate);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['active'] = Variable<bool>(active);
    return map;
  }

  WorkersCompanion toCompanion(bool nullToAbsent) {
    return WorkersCompanion(
      id: Value(id),
      fullName: Value(fullName),
      dailyRate: Value(dailyRate),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      active: Value(active),
    );
  }

  factory Worker.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Worker(
      id: serializer.fromJson<int>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      dailyRate: serializer.fromJson<int>(json['dailyRate']),
      phone: serializer.fromJson<String?>(json['phone']),
      note: serializer.fromJson<String?>(json['note']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fullName': serializer.toJson<String>(fullName),
      'dailyRate': serializer.toJson<int>(dailyRate),
      'phone': serializer.toJson<String?>(phone),
      'note': serializer.toJson<String?>(note),
      'active': serializer.toJson<bool>(active),
    };
  }

  Worker copyWith(
          {int? id,
          String? fullName,
          int? dailyRate,
          Value<String?> phone = const Value.absent(),
          Value<String?> note = const Value.absent(),
          bool? active}) =>
      Worker(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        dailyRate: dailyRate ?? this.dailyRate,
        phone: phone.present ? phone.value : this.phone,
        note: note.present ? note.value : this.note,
        active: active ?? this.active,
      );
  Worker copyWithCompanion(WorkersCompanion data) {
    return Worker(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      dailyRate: data.dailyRate.present ? data.dailyRate.value : this.dailyRate,
      phone: data.phone.present ? data.phone.value : this.phone,
      note: data.note.present ? data.note.value : this.note,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Worker(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('dailyRate: $dailyRate, ')
          ..write('phone: $phone, ')
          ..write('note: $note, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fullName, dailyRate, phone, note, active);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Worker &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.dailyRate == this.dailyRate &&
          other.phone == this.phone &&
          other.note == this.note &&
          other.active == this.active);
}

class WorkersCompanion extends UpdateCompanion<Worker> {
  final Value<int> id;
  final Value<String> fullName;
  final Value<int> dailyRate;
  final Value<String?> phone;
  final Value<String?> note;
  final Value<bool> active;
  const WorkersCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.dailyRate = const Value.absent(),
    this.phone = const Value.absent(),
    this.note = const Value.absent(),
    this.active = const Value.absent(),
  });
  WorkersCompanion.insert({
    this.id = const Value.absent(),
    required String fullName,
    required int dailyRate,
    this.phone = const Value.absent(),
    this.note = const Value.absent(),
    this.active = const Value.absent(),
  })  : fullName = Value(fullName),
        dailyRate = Value(dailyRate);
  static Insertable<Worker> custom({
    Expression<int>? id,
    Expression<String>? fullName,
    Expression<int>? dailyRate,
    Expression<String>? phone,
    Expression<String>? note,
    Expression<bool>? active,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (dailyRate != null) 'daily_rate': dailyRate,
      if (phone != null) 'phone': phone,
      if (note != null) 'note': note,
      if (active != null) 'active': active,
    });
  }

  WorkersCompanion copyWith(
      {Value<int>? id,
      Value<String>? fullName,
      Value<int>? dailyRate,
      Value<String?>? phone,
      Value<String?>? note,
      Value<bool>? active}) {
    return WorkersCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      dailyRate: dailyRate ?? this.dailyRate,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (dailyRate.present) {
      map['daily_rate'] = Variable<int>(dailyRate.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkersCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('dailyRate: $dailyRate, ')
          ..write('phone: $phone, ')
          ..write('note: $note, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }
}

class $WorkerAssignmentsTable extends WorkerAssignments
    with TableInfo<$WorkerAssignmentsTable, WorkerAssignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkerAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workerIdMeta =
      const VerificationMeta('workerId');
  @override
  late final GeneratedColumn<int> workerId = GeneratedColumn<int>(
      'worker_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workers (id)'));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
      'project_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES projects (id)'));
  static const VerificationMeta _workDateMeta =
      const VerificationMeta('workDate');
  @override
  late final GeneratedColumn<DateTime> workDate = GeneratedColumn<DateTime>(
      'work_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _hoursMeta = const VerificationMeta('hours');
  @override
  late final GeneratedColumn<int> hours = GeneratedColumn<int>(
      'hours', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(8));
  static const VerificationMeta _overtimeHoursMeta =
      const VerificationMeta('overtimeHours');
  @override
  late final GeneratedColumn<int> overtimeHours = GeneratedColumn<int>(
      'overtime_hours', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, workerId, projectId, workDate, hours, overtimeHours];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'worker_assignments';
  @override
  VerificationContext validateIntegrity(Insertable<WorkerAssignment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('worker_id')) {
      context.handle(_workerIdMeta,
          workerId.isAcceptableOrUnknown(data['worker_id']!, _workerIdMeta));
    } else if (isInserting) {
      context.missing(_workerIdMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('work_date')) {
      context.handle(_workDateMeta,
          workDate.isAcceptableOrUnknown(data['work_date']!, _workDateMeta));
    } else if (isInserting) {
      context.missing(_workDateMeta);
    }
    if (data.containsKey('hours')) {
      context.handle(
          _hoursMeta, hours.isAcceptableOrUnknown(data['hours']!, _hoursMeta));
    }
    if (data.containsKey('overtime_hours')) {
      context.handle(
          _overtimeHoursMeta,
          overtimeHours.isAcceptableOrUnknown(
              data['overtime_hours']!, _overtimeHoursMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkerAssignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkerAssignment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}worker_id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project_id'])!,
      workDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}work_date'])!,
      hours: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hours'])!,
      overtimeHours: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}overtime_hours'])!,
    );
  }

  @override
  $WorkerAssignmentsTable createAlias(String alias) {
    return $WorkerAssignmentsTable(attachedDatabase, alias);
  }
}

class WorkerAssignment extends DataClass
    implements Insertable<WorkerAssignment> {
  final int id;
  final int workerId;
  final int projectId;
  final DateTime workDate;
  final int hours;
  final int overtimeHours;
  const WorkerAssignment(
      {required this.id,
      required this.workerId,
      required this.projectId,
      required this.workDate,
      required this.hours,
      required this.overtimeHours});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['worker_id'] = Variable<int>(workerId);
    map['project_id'] = Variable<int>(projectId);
    map['work_date'] = Variable<DateTime>(workDate);
    map['hours'] = Variable<int>(hours);
    map['overtime_hours'] = Variable<int>(overtimeHours);
    return map;
  }

  WorkerAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return WorkerAssignmentsCompanion(
      id: Value(id),
      workerId: Value(workerId),
      projectId: Value(projectId),
      workDate: Value(workDate),
      hours: Value(hours),
      overtimeHours: Value(overtimeHours),
    );
  }

  factory WorkerAssignment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkerAssignment(
      id: serializer.fromJson<int>(json['id']),
      workerId: serializer.fromJson<int>(json['workerId']),
      projectId: serializer.fromJson<int>(json['projectId']),
      workDate: serializer.fromJson<DateTime>(json['workDate']),
      hours: serializer.fromJson<int>(json['hours']),
      overtimeHours: serializer.fromJson<int>(json['overtimeHours']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workerId': serializer.toJson<int>(workerId),
      'projectId': serializer.toJson<int>(projectId),
      'workDate': serializer.toJson<DateTime>(workDate),
      'hours': serializer.toJson<int>(hours),
      'overtimeHours': serializer.toJson<int>(overtimeHours),
    };
  }

  WorkerAssignment copyWith(
          {int? id,
          int? workerId,
          int? projectId,
          DateTime? workDate,
          int? hours,
          int? overtimeHours}) =>
      WorkerAssignment(
        id: id ?? this.id,
        workerId: workerId ?? this.workerId,
        projectId: projectId ?? this.projectId,
        workDate: workDate ?? this.workDate,
        hours: hours ?? this.hours,
        overtimeHours: overtimeHours ?? this.overtimeHours,
      );
  WorkerAssignment copyWithCompanion(WorkerAssignmentsCompanion data) {
    return WorkerAssignment(
      id: data.id.present ? data.id.value : this.id,
      workerId: data.workerId.present ? data.workerId.value : this.workerId,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      workDate: data.workDate.present ? data.workDate.value : this.workDate,
      hours: data.hours.present ? data.hours.value : this.hours,
      overtimeHours: data.overtimeHours.present
          ? data.overtimeHours.value
          : this.overtimeHours,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkerAssignment(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('projectId: $projectId, ')
          ..write('workDate: $workDate, ')
          ..write('hours: $hours, ')
          ..write('overtimeHours: $overtimeHours')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workerId, projectId, workDate, hours, overtimeHours);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkerAssignment &&
          other.id == this.id &&
          other.workerId == this.workerId &&
          other.projectId == this.projectId &&
          other.workDate == this.workDate &&
          other.hours == this.hours &&
          other.overtimeHours == this.overtimeHours);
}

class WorkerAssignmentsCompanion extends UpdateCompanion<WorkerAssignment> {
  final Value<int> id;
  final Value<int> workerId;
  final Value<int> projectId;
  final Value<DateTime> workDate;
  final Value<int> hours;
  final Value<int> overtimeHours;
  const WorkerAssignmentsCompanion({
    this.id = const Value.absent(),
    this.workerId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.workDate = const Value.absent(),
    this.hours = const Value.absent(),
    this.overtimeHours = const Value.absent(),
  });
  WorkerAssignmentsCompanion.insert({
    this.id = const Value.absent(),
    required int workerId,
    required int projectId,
    required DateTime workDate,
    this.hours = const Value.absent(),
    this.overtimeHours = const Value.absent(),
  })  : workerId = Value(workerId),
        projectId = Value(projectId),
        workDate = Value(workDate);
  static Insertable<WorkerAssignment> custom({
    Expression<int>? id,
    Expression<int>? workerId,
    Expression<int>? projectId,
    Expression<DateTime>? workDate,
    Expression<int>? hours,
    Expression<int>? overtimeHours,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workerId != null) 'worker_id': workerId,
      if (projectId != null) 'project_id': projectId,
      if (workDate != null) 'work_date': workDate,
      if (hours != null) 'hours': hours,
      if (overtimeHours != null) 'overtime_hours': overtimeHours,
    });
  }

  WorkerAssignmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? workerId,
      Value<int>? projectId,
      Value<DateTime>? workDate,
      Value<int>? hours,
      Value<int>? overtimeHours}) {
    return WorkerAssignmentsCompanion(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      projectId: projectId ?? this.projectId,
      workDate: workDate ?? this.workDate,
      hours: hours ?? this.hours,
      overtimeHours: overtimeHours ?? this.overtimeHours,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workerId.present) {
      map['worker_id'] = Variable<int>(workerId.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (workDate.present) {
      map['work_date'] = Variable<DateTime>(workDate.value);
    }
    if (hours.present) {
      map['hours'] = Variable<int>(hours.value);
    }
    if (overtimeHours.present) {
      map['overtime_hours'] = Variable<int>(overtimeHours.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkerAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('projectId: $projectId, ')
          ..write('workDate: $workDate, ')
          ..write('hours: $hours, ')
          ..write('overtimeHours: $overtimeHours')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workerIdMeta =
      const VerificationMeta('workerId');
  @override
  late final GeneratedColumn<int> workerId = GeneratedColumn<int>(
      'worker_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workers (id)'));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
      'project_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES projects (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paymentDateMeta =
      const VerificationMeta('paymentDate');
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
      'payment_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workerId, projectId, amount, paymentDate, method, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<Payment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('worker_id')) {
      context.handle(_workerIdMeta,
          workerId.isAcceptableOrUnknown(data['worker_id']!, _workerIdMeta));
    } else if (isInserting) {
      context.missing(_workerIdMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
          _paymentDateMeta,
          paymentDate.isAcceptableOrUnknown(
              data['payment_date']!, _paymentDateMeta));
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}worker_id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project_id']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      paymentDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}payment_date'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int workerId;
  final int? projectId;
  final int amount;
  final DateTime paymentDate;
  final String method;
  final String? note;
  const Payment(
      {required this.id,
      required this.workerId,
      this.projectId,
      required this.amount,
      required this.paymentDate,
      required this.method,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['worker_id'] = Variable<int>(workerId);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<int>(projectId);
    }
    map['amount'] = Variable<int>(amount);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      workerId: Value(workerId),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      amount: Value(amount),
      paymentDate: Value(paymentDate),
      method: Value(method),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      workerId: serializer.fromJson<int>(json['workerId']),
      projectId: serializer.fromJson<int?>(json['projectId']),
      amount: serializer.fromJson<int>(json['amount']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      method: serializer.fromJson<String>(json['method']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workerId': serializer.toJson<int>(workerId),
      'projectId': serializer.toJson<int?>(projectId),
      'amount': serializer.toJson<int>(amount),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'method': serializer.toJson<String>(method),
      'note': serializer.toJson<String?>(note),
    };
  }

  Payment copyWith(
          {int? id,
          int? workerId,
          Value<int?> projectId = const Value.absent(),
          int? amount,
          DateTime? paymentDate,
          String? method,
          Value<String?> note = const Value.absent()}) =>
      Payment(
        id: id ?? this.id,
        workerId: workerId ?? this.workerId,
        projectId: projectId.present ? projectId.value : this.projectId,
        amount: amount ?? this.amount,
        paymentDate: paymentDate ?? this.paymentDate,
        method: method ?? this.method,
        note: note.present ? note.value : this.note,
      );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      workerId: data.workerId.present ? data.workerId.value : this.workerId,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentDate:
          data.paymentDate.present ? data.paymentDate.value : this.paymentDate,
      method: data.method.present ? data.method.value : this.method,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('projectId: $projectId, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('method: $method, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workerId, projectId, amount, paymentDate, method, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.workerId == this.workerId &&
          other.projectId == this.projectId &&
          other.amount == this.amount &&
          other.paymentDate == this.paymentDate &&
          other.method == this.method &&
          other.note == this.note);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> workerId;
  final Value<int?> projectId;
  final Value<int> amount;
  final Value<DateTime> paymentDate;
  final Value<String> method;
  final Value<String?> note;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.workerId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.method = const Value.absent(),
    this.note = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int workerId,
    this.projectId = const Value.absent(),
    required int amount,
    required DateTime paymentDate,
    required String method,
    this.note = const Value.absent(),
  })  : workerId = Value(workerId),
        amount = Value(amount),
        paymentDate = Value(paymentDate),
        method = Value(method);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? workerId,
    Expression<int>? projectId,
    Expression<int>? amount,
    Expression<DateTime>? paymentDate,
    Expression<String>? method,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workerId != null) 'worker_id': workerId,
      if (projectId != null) 'project_id': projectId,
      if (amount != null) 'amount': amount,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (method != null) 'method': method,
      if (note != null) 'note': note,
    });
  }

  PaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? workerId,
      Value<int?>? projectId,
      Value<int>? amount,
      Value<DateTime>? paymentDate,
      Value<String>? method,
      Value<String?>? note}) {
    return PaymentsCompanion(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      projectId: projectId ?? this.projectId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      method: method ?? this.method,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workerId.present) {
      map['worker_id'] = Variable<int>(workerId.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('projectId: $projectId, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('method: $method, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $WeeklySnapshotsTable extends WeeklySnapshots
    with TableInfo<$WeeklySnapshotsTable, WeeklySnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklySnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _weekStartMeta =
      const VerificationMeta('weekStart');
  @override
  late final GeneratedColumn<DateTime> weekStart = GeneratedColumn<DateTime>(
      'week_start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _incomeTotalMeta =
      const VerificationMeta('incomeTotal');
  @override
  late final GeneratedColumn<int> incomeTotal = GeneratedColumn<int>(
      'income_total', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _expenseTotalMeta =
      const VerificationMeta('expenseTotal');
  @override
  late final GeneratedColumn<int> expenseTotal = GeneratedColumn<int>(
      'expense_total', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _debtTotalMeta =
      const VerificationMeta('debtTotal');
  @override
  late final GeneratedColumn<int> debtTotal = GeneratedColumn<int>(
      'debt_total', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _payrollTotalMeta =
      const VerificationMeta('payrollTotal');
  @override
  late final GeneratedColumn<int> payrollTotal = GeneratedColumn<int>(
      'payroll_total', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _generatedAtMeta =
      const VerificationMeta('generatedAt');
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
      'generated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        weekStart,
        incomeTotal,
        expenseTotal,
        debtTotal,
        payrollTotal,
        generatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_snapshots';
  @override
  VerificationContext validateIntegrity(Insertable<WeeklySnapshot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('week_start')) {
      context.handle(_weekStartMeta,
          weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta));
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('income_total')) {
      context.handle(
          _incomeTotalMeta,
          incomeTotal.isAcceptableOrUnknown(
              data['income_total']!, _incomeTotalMeta));
    } else if (isInserting) {
      context.missing(_incomeTotalMeta);
    }
    if (data.containsKey('expense_total')) {
      context.handle(
          _expenseTotalMeta,
          expenseTotal.isAcceptableOrUnknown(
              data['expense_total']!, _expenseTotalMeta));
    } else if (isInserting) {
      context.missing(_expenseTotalMeta);
    }
    if (data.containsKey('debt_total')) {
      context.handle(_debtTotalMeta,
          debtTotal.isAcceptableOrUnknown(data['debt_total']!, _debtTotalMeta));
    } else if (isInserting) {
      context.missing(_debtTotalMeta);
    }
    if (data.containsKey('payroll_total')) {
      context.handle(
          _payrollTotalMeta,
          payrollTotal.isAcceptableOrUnknown(
              data['payroll_total']!, _payrollTotalMeta));
    } else if (isInserting) {
      context.missing(_payrollTotalMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
          _generatedAtMeta,
          generatedAt.isAcceptableOrUnknown(
              data['generated_at']!, _generatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklySnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklySnapshot(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      weekStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}week_start'])!,
      incomeTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}income_total'])!,
      expenseTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}expense_total'])!,
      debtTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}debt_total'])!,
      payrollTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payroll_total'])!,
      generatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}generated_at'])!,
    );
  }

  @override
  $WeeklySnapshotsTable createAlias(String alias) {
    return $WeeklySnapshotsTable(attachedDatabase, alias);
  }
}

class WeeklySnapshot extends DataClass implements Insertable<WeeklySnapshot> {
  final int id;
  final DateTime weekStart;
  final int incomeTotal;
  final int expenseTotal;
  final int debtTotal;
  final int payrollTotal;
  final DateTime generatedAt;
  const WeeklySnapshot(
      {required this.id,
      required this.weekStart,
      required this.incomeTotal,
      required this.expenseTotal,
      required this.debtTotal,
      required this.payrollTotal,
      required this.generatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['week_start'] = Variable<DateTime>(weekStart);
    map['income_total'] = Variable<int>(incomeTotal);
    map['expense_total'] = Variable<int>(expenseTotal);
    map['debt_total'] = Variable<int>(debtTotal);
    map['payroll_total'] = Variable<int>(payrollTotal);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  WeeklySnapshotsCompanion toCompanion(bool nullToAbsent) {
    return WeeklySnapshotsCompanion(
      id: Value(id),
      weekStart: Value(weekStart),
      incomeTotal: Value(incomeTotal),
      expenseTotal: Value(expenseTotal),
      debtTotal: Value(debtTotal),
      payrollTotal: Value(payrollTotal),
      generatedAt: Value(generatedAt),
    );
  }

  factory WeeklySnapshot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklySnapshot(
      id: serializer.fromJson<int>(json['id']),
      weekStart: serializer.fromJson<DateTime>(json['weekStart']),
      incomeTotal: serializer.fromJson<int>(json['incomeTotal']),
      expenseTotal: serializer.fromJson<int>(json['expenseTotal']),
      debtTotal: serializer.fromJson<int>(json['debtTotal']),
      payrollTotal: serializer.fromJson<int>(json['payrollTotal']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'weekStart': serializer.toJson<DateTime>(weekStart),
      'incomeTotal': serializer.toJson<int>(incomeTotal),
      'expenseTotal': serializer.toJson<int>(expenseTotal),
      'debtTotal': serializer.toJson<int>(debtTotal),
      'payrollTotal': serializer.toJson<int>(payrollTotal),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  WeeklySnapshot copyWith(
          {int? id,
          DateTime? weekStart,
          int? incomeTotal,
          int? expenseTotal,
          int? debtTotal,
          int? payrollTotal,
          DateTime? generatedAt}) =>
      WeeklySnapshot(
        id: id ?? this.id,
        weekStart: weekStart ?? this.weekStart,
        incomeTotal: incomeTotal ?? this.incomeTotal,
        expenseTotal: expenseTotal ?? this.expenseTotal,
        debtTotal: debtTotal ?? this.debtTotal,
        payrollTotal: payrollTotal ?? this.payrollTotal,
        generatedAt: generatedAt ?? this.generatedAt,
      );
  WeeklySnapshot copyWithCompanion(WeeklySnapshotsCompanion data) {
    return WeeklySnapshot(
      id: data.id.present ? data.id.value : this.id,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      incomeTotal:
          data.incomeTotal.present ? data.incomeTotal.value : this.incomeTotal,
      expenseTotal: data.expenseTotal.present
          ? data.expenseTotal.value
          : this.expenseTotal,
      debtTotal: data.debtTotal.present ? data.debtTotal.value : this.debtTotal,
      payrollTotal: data.payrollTotal.present
          ? data.payrollTotal.value
          : this.payrollTotal,
      generatedAt:
          data.generatedAt.present ? data.generatedAt.value : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklySnapshot(')
          ..write('id: $id, ')
          ..write('weekStart: $weekStart, ')
          ..write('incomeTotal: $incomeTotal, ')
          ..write('expenseTotal: $expenseTotal, ')
          ..write('debtTotal: $debtTotal, ')
          ..write('payrollTotal: $payrollTotal, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, weekStart, incomeTotal, expenseTotal,
      debtTotal, payrollTotal, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklySnapshot &&
          other.id == this.id &&
          other.weekStart == this.weekStart &&
          other.incomeTotal == this.incomeTotal &&
          other.expenseTotal == this.expenseTotal &&
          other.debtTotal == this.debtTotal &&
          other.payrollTotal == this.payrollTotal &&
          other.generatedAt == this.generatedAt);
}

class WeeklySnapshotsCompanion extends UpdateCompanion<WeeklySnapshot> {
  final Value<int> id;
  final Value<DateTime> weekStart;
  final Value<int> incomeTotal;
  final Value<int> expenseTotal;
  final Value<int> debtTotal;
  final Value<int> payrollTotal;
  final Value<DateTime> generatedAt;
  const WeeklySnapshotsCompanion({
    this.id = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.incomeTotal = const Value.absent(),
    this.expenseTotal = const Value.absent(),
    this.debtTotal = const Value.absent(),
    this.payrollTotal = const Value.absent(),
    this.generatedAt = const Value.absent(),
  });
  WeeklySnapshotsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime weekStart,
    required int incomeTotal,
    required int expenseTotal,
    required int debtTotal,
    required int payrollTotal,
    this.generatedAt = const Value.absent(),
  })  : weekStart = Value(weekStart),
        incomeTotal = Value(incomeTotal),
        expenseTotal = Value(expenseTotal),
        debtTotal = Value(debtTotal),
        payrollTotal = Value(payrollTotal);
  static Insertable<WeeklySnapshot> custom({
    Expression<int>? id,
    Expression<DateTime>? weekStart,
    Expression<int>? incomeTotal,
    Expression<int>? expenseTotal,
    Expression<int>? debtTotal,
    Expression<int>? payrollTotal,
    Expression<DateTime>? generatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekStart != null) 'week_start': weekStart,
      if (incomeTotal != null) 'income_total': incomeTotal,
      if (expenseTotal != null) 'expense_total': expenseTotal,
      if (debtTotal != null) 'debt_total': debtTotal,
      if (payrollTotal != null) 'payroll_total': payrollTotal,
      if (generatedAt != null) 'generated_at': generatedAt,
    });
  }

  WeeklySnapshotsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? weekStart,
      Value<int>? incomeTotal,
      Value<int>? expenseTotal,
      Value<int>? debtTotal,
      Value<int>? payrollTotal,
      Value<DateTime>? generatedAt}) {
    return WeeklySnapshotsCompanion(
      id: id ?? this.id,
      weekStart: weekStart ?? this.weekStart,
      incomeTotal: incomeTotal ?? this.incomeTotal,
      expenseTotal: expenseTotal ?? this.expenseTotal,
      debtTotal: debtTotal ?? this.debtTotal,
      payrollTotal: payrollTotal ?? this.payrollTotal,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<DateTime>(weekStart.value);
    }
    if (incomeTotal.present) {
      map['income_total'] = Variable<int>(incomeTotal.value);
    }
    if (expenseTotal.present) {
      map['expense_total'] = Variable<int>(expenseTotal.value);
    }
    if (debtTotal.present) {
      map['debt_total'] = Variable<int>(debtTotal.value);
    }
    if (payrollTotal.present) {
      map['payroll_total'] = Variable<int>(payrollTotal.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklySnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('weekStart: $weekStart, ')
          ..write('incomeTotal: $incomeTotal, ')
          ..write('expenseTotal: $expenseTotal, ')
          ..write('debtTotal: $debtTotal, ')
          ..write('payrollTotal: $payrollTotal, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EmployersTable employers = $EmployersTable(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $IncomeExpenseTable incomeExpense = $IncomeExpenseTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final $DebtPaymentsTable debtPayments = $DebtPaymentsTable(this);
  late final $WorkersTable workers = $WorkersTable(this);
  late final $WorkerAssignmentsTable workerAssignments =
      $WorkerAssignmentsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $WeeklySnapshotsTable weeklySnapshots =
      $WeeklySnapshotsTable(this);
  late final EmployerDao employerDao = EmployerDao(this as AppDatabase);
  late final ProjectDao projectDao = ProjectDao(this as AppDatabase);
  late final FinanceDao financeDao = FinanceDao(this as AppDatabase);
  late final DebtDao debtDao = DebtDao(this as AppDatabase);
  late final WorkerDao workerDao = WorkerDao(this as AppDatabase);
  late final ReportDao reportDao = ReportDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        employers,
        projects,
        incomeExpense,
        debts,
        debtPayments,
        workers,
        workerAssignments,
        payments,
        weeklySnapshots
      ];
}

typedef $$EmployersTableCreateCompanionBuilder = EmployersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> contact,
  Value<String?> note,
  Value<int> totalCreditLimit,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$EmployersTableUpdateCompanionBuilder = EmployersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> contact,
  Value<String?> note,
  Value<int> totalCreditLimit,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$EmployersTableReferences
    extends BaseReferences<_$AppDatabase, $EmployersTable, Employer> {
  $$EmployersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProjectsTable, List<Project>> _projectsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.projects,
          aliasName:
              $_aliasNameGenerator(db.employers.id, db.projects.employerId));

  $$ProjectsTableProcessedTableManager get projectsRefs {
    final manager = $$ProjectsTableTableManager($_db, $_db.projects)
        .filter((f) => f.employerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_projectsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$IncomeExpenseTable, List<IncomeExpenseData>>
      _incomeExpenseRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.incomeExpense,
              aliasName: $_aliasNameGenerator(
                  db.employers.id, db.incomeExpense.employerId));

  $$IncomeExpenseTableProcessedTableManager get incomeExpenseRefs {
    final manager = $$IncomeExpenseTableTableManager($_db, $_db.incomeExpense)
        .filter((f) => f.employerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_incomeExpenseRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DebtsTable, List<Debt>> _debtsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.debts,
          aliasName:
              $_aliasNameGenerator(db.employers.id, db.debts.employerId));

  $$DebtsTableProcessedTableManager get debtsRefs {
    final manager = $$DebtsTableTableManager($_db, $_db.debts)
        .filter((f) => f.employerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EmployersTableFilterComposer
    extends Composer<_$AppDatabase, $EmployersTable> {
  $$EmployersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contact => $composableBuilder(
      column: $table.contact, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalCreditLimit => $composableBuilder(
      column: $table.totalCreditLimit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> projectsRefs(
      Expression<bool> Function($$ProjectsTableFilterComposer f) f) {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.employerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableFilterComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> incomeExpenseRefs(
      Expression<bool> Function($$IncomeExpenseTableFilterComposer f) f) {
    final $$IncomeExpenseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incomeExpense,
        getReferencedColumn: (t) => t.employerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncomeExpenseTableFilterComposer(
              $db: $db,
              $table: $db.incomeExpense,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> debtsRefs(
      Expression<bool> Function($$DebtsTableFilterComposer f) f) {
    final $$DebtsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.employerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableFilterComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EmployersTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployersTable> {
  $$EmployersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contact => $composableBuilder(
      column: $table.contact, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalCreditLimit => $composableBuilder(
      column: $table.totalCreditLimit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$EmployersTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployersTable> {
  $$EmployersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get contact =>
      $composableBuilder(column: $table.contact, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get totalCreditLimit => $composableBuilder(
      column: $table.totalCreditLimit, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> projectsRefs<T extends Object>(
      Expression<T> Function($$ProjectsTableAnnotationComposer a) f) {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.employerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> incomeExpenseRefs<T extends Object>(
      Expression<T> Function($$IncomeExpenseTableAnnotationComposer a) f) {
    final $$IncomeExpenseTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incomeExpense,
        getReferencedColumn: (t) => t.employerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncomeExpenseTableAnnotationComposer(
              $db: $db,
              $table: $db.incomeExpense,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> debtsRefs<T extends Object>(
      Expression<T> Function($$DebtsTableAnnotationComposer a) f) {
    final $$DebtsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.employerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableAnnotationComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EmployersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EmployersTable,
    Employer,
    $$EmployersTableFilterComposer,
    $$EmployersTableOrderingComposer,
    $$EmployersTableAnnotationComposer,
    $$EmployersTableCreateCompanionBuilder,
    $$EmployersTableUpdateCompanionBuilder,
    (Employer, $$EmployersTableReferences),
    Employer,
    PrefetchHooks Function(
        {bool projectsRefs, bool incomeExpenseRefs, bool debtsRefs})> {
  $$EmployersTableTableManager(_$AppDatabase db, $EmployersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> contact = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> totalCreditLimit = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              EmployersCompanion(
            id: id,
            name: name,
            contact: contact,
            note: note,
            totalCreditLimit: totalCreditLimit,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> contact = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> totalCreditLimit = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              EmployersCompanion.insert(
            id: id,
            name: name,
            contact: contact,
            note: note,
            totalCreditLimit: totalCreditLimit,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EmployersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {projectsRefs = false,
              incomeExpenseRefs = false,
              debtsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (projectsRefs) db.projects,
                if (incomeExpenseRefs) db.incomeExpense,
                if (debtsRefs) db.debts
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (projectsRefs)
                    await $_getPrefetchedData<Employer, $EmployersTable,
                            Project>(
                        currentTable: table,
                        referencedTable:
                            $$EmployersTableReferences._projectsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployersTableReferences(db, table, p0)
                                .projectsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employerId == item.id),
                        typedResults: items),
                  if (incomeExpenseRefs)
                    await $_getPrefetchedData<Employer, $EmployersTable,
                            IncomeExpenseData>(
                        currentTable: table,
                        referencedTable: $$EmployersTableReferences
                            ._incomeExpenseRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployersTableReferences(db, table, p0)
                                .incomeExpenseRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employerId == item.id),
                        typedResults: items),
                  if (debtsRefs)
                    await $_getPrefetchedData<Employer, $EmployersTable, Debt>(
                        currentTable: table,
                        referencedTable:
                            $$EmployersTableReferences._debtsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployersTableReferences(db, table, p0).debtsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EmployersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EmployersTable,
    Employer,
    $$EmployersTableFilterComposer,
    $$EmployersTableOrderingComposer,
    $$EmployersTableAnnotationComposer,
    $$EmployersTableCreateCompanionBuilder,
    $$EmployersTableUpdateCompanionBuilder,
    (Employer, $$EmployersTableReferences),
    Employer,
    PrefetchHooks Function(
        {bool projectsRefs, bool incomeExpenseRefs, bool debtsRefs})>;
typedef $$ProjectsTableCreateCompanionBuilder = ProjectsCompanion Function({
  Value<int> id,
  required int employerId,
  required String title,
  required DateTime startDate,
  Value<DateTime?> endDate,
  required String status,
  required int budget,
  Value<String?> description,
});
typedef $$ProjectsTableUpdateCompanionBuilder = ProjectsCompanion Function({
  Value<int> id,
  Value<int> employerId,
  Value<String> title,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<String> status,
  Value<int> budget,
  Value<String?> description,
});

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, Project> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EmployersTable _employerIdTable(_$AppDatabase db) =>
      db.employers.createAlias(
          $_aliasNameGenerator(db.projects.employerId, db.employers.id));

  $$EmployersTableProcessedTableManager get employerId {
    final $_column = $_itemColumn<int>('employer_id')!;

    final manager = $$EmployersTableTableManager($_db, $_db.employers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$IncomeExpenseTable, List<IncomeExpenseData>>
      _incomeExpenseRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.incomeExpense,
              aliasName: $_aliasNameGenerator(
                  db.projects.id, db.incomeExpense.projectId));

  $$IncomeExpenseTableProcessedTableManager get incomeExpenseRefs {
    final manager = $$IncomeExpenseTableTableManager($_db, $_db.incomeExpense)
        .filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_incomeExpenseRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DebtsTable, List<Debt>> _debtsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.debts,
          aliasName: $_aliasNameGenerator(db.projects.id, db.debts.projectId));

  $$DebtsTableProcessedTableManager get debtsRefs {
    final manager = $$DebtsTableTableManager($_db, $_db.debts)
        .filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkerAssignmentsTable, List<WorkerAssignment>>
      _workerAssignmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.workerAssignments,
              aliasName: $_aliasNameGenerator(
                  db.projects.id, db.workerAssignments.projectId));

  $$WorkerAssignmentsTableProcessedTableManager get workerAssignmentsRefs {
    final manager =
        $$WorkerAssignmentsTableTableManager($_db, $_db.workerAssignments)
            .filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_workerAssignmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.payments,
          aliasName:
              $_aliasNameGenerator(db.projects.id, db.payments.projectId));

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager($_db, $_db.payments)
        .filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get budget => $composableBuilder(
      column: $table.budget, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  $$EmployersTableFilterComposer get employerId {
    final $$EmployersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employerId,
        referencedTable: $db.employers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployersTableFilterComposer(
              $db: $db,
              $table: $db.employers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> incomeExpenseRefs(
      Expression<bool> Function($$IncomeExpenseTableFilterComposer f) f) {
    final $$IncomeExpenseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incomeExpense,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncomeExpenseTableFilterComposer(
              $db: $db,
              $table: $db.incomeExpense,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> debtsRefs(
      Expression<bool> Function($$DebtsTableFilterComposer f) f) {
    final $$DebtsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableFilterComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> workerAssignmentsRefs(
      Expression<bool> Function($$WorkerAssignmentsTableFilterComposer f) f) {
    final $$WorkerAssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workerAssignments,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkerAssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.workerAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> paymentsRefs(
      Expression<bool> Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get budget => $composableBuilder(
      column: $table.budget, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  $$EmployersTableOrderingComposer get employerId {
    final $$EmployersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employerId,
        referencedTable: $db.employers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployersTableOrderingComposer(
              $db: $db,
              $table: $db.employers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get budget =>
      $composableBuilder(column: $table.budget, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  $$EmployersTableAnnotationComposer get employerId {
    final $$EmployersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employerId,
        referencedTable: $db.employers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployersTableAnnotationComposer(
              $db: $db,
              $table: $db.employers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> incomeExpenseRefs<T extends Object>(
      Expression<T> Function($$IncomeExpenseTableAnnotationComposer a) f) {
    final $$IncomeExpenseTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incomeExpense,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncomeExpenseTableAnnotationComposer(
              $db: $db,
              $table: $db.incomeExpense,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> debtsRefs<T extends Object>(
      Expression<T> Function($$DebtsTableAnnotationComposer a) f) {
    final $$DebtsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableAnnotationComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> workerAssignmentsRefs<T extends Object>(
      Expression<T> Function($$WorkerAssignmentsTableAnnotationComposer a) f) {
    final $$WorkerAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.workerAssignments,
            getReferencedColumn: (t) => t.projectId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WorkerAssignmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.workerAssignments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
      Expression<T> Function($$PaymentsTableAnnotationComposer a) f) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProjectsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProjectsTable,
    Project,
    $$ProjectsTableFilterComposer,
    $$ProjectsTableOrderingComposer,
    $$ProjectsTableAnnotationComposer,
    $$ProjectsTableCreateCompanionBuilder,
    $$ProjectsTableUpdateCompanionBuilder,
    (Project, $$ProjectsTableReferences),
    Project,
    PrefetchHooks Function(
        {bool employerId,
        bool incomeExpenseRefs,
        bool debtsRefs,
        bool workerAssignmentsRefs,
        bool paymentsRefs})> {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> employerId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> budget = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              ProjectsCompanion(
            id: id,
            employerId: employerId,
            title: title,
            startDate: startDate,
            endDate: endDate,
            status: status,
            budget: budget,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int employerId,
            required String title,
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            required String status,
            required int budget,
            Value<String?> description = const Value.absent(),
          }) =>
              ProjectsCompanion.insert(
            id: id,
            employerId: employerId,
            title: title,
            startDate: startDate,
            endDate: endDate,
            status: status,
            budget: budget,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProjectsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {employerId = false,
              incomeExpenseRefs = false,
              debtsRefs = false,
              workerAssignmentsRefs = false,
              paymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (incomeExpenseRefs) db.incomeExpense,
                if (debtsRefs) db.debts,
                if (workerAssignmentsRefs) db.workerAssignments,
                if (paymentsRefs) db.payments
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employerId,
                    referencedTable:
                        $$ProjectsTableReferences._employerIdTable(db),
                    referencedColumn:
                        $$ProjectsTableReferences._employerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (incomeExpenseRefs)
                    await $_getPrefetchedData<Project, $ProjectsTable,
                            IncomeExpenseData>(
                        currentTable: table,
                        referencedTable: $$ProjectsTableReferences
                            ._incomeExpenseRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProjectsTableReferences(db, table, p0)
                                .incomeExpenseRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.projectId == item.id),
                        typedResults: items),
                  if (debtsRefs)
                    await $_getPrefetchedData<Project, $ProjectsTable, Debt>(
                        currentTable: table,
                        referencedTable:
                            $$ProjectsTableReferences._debtsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProjectsTableReferences(db, table, p0).debtsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.projectId == item.id),
                        typedResults: items),
                  if (workerAssignmentsRefs)
                    await $_getPrefetchedData<Project, $ProjectsTable,
                            WorkerAssignment>(
                        currentTable: table,
                        referencedTable: $$ProjectsTableReferences
                            ._workerAssignmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProjectsTableReferences(db, table, p0)
                                .workerAssignmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.projectId == item.id),
                        typedResults: items),
                  if (paymentsRefs)
                    await $_getPrefetchedData<Project, $ProjectsTable, Payment>(
                        currentTable: table,
                        referencedTable:
                            $$ProjectsTableReferences._paymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProjectsTableReferences(db, table, p0)
                                .paymentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.projectId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProjectsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProjectsTable,
    Project,
    $$ProjectsTableFilterComposer,
    $$ProjectsTableOrderingComposer,
    $$ProjectsTableAnnotationComposer,
    $$ProjectsTableCreateCompanionBuilder,
    $$ProjectsTableUpdateCompanionBuilder,
    (Project, $$ProjectsTableReferences),
    Project,
    PrefetchHooks Function(
        {bool employerId,
        bool incomeExpenseRefs,
        bool debtsRefs,
        bool workerAssignmentsRefs,
        bool paymentsRefs})>;
typedef $$IncomeExpenseTableCreateCompanionBuilder = IncomeExpenseCompanion
    Function({
  Value<int> id,
  Value<int?> projectId,
  Value<int?> employerId,
  required String type,
  required String category,
  required int amount,
  Value<String?> description,
  required DateTime txDate,
});
typedef $$IncomeExpenseTableUpdateCompanionBuilder = IncomeExpenseCompanion
    Function({
  Value<int> id,
  Value<int?> projectId,
  Value<int?> employerId,
  Value<String> type,
  Value<String> category,
  Value<int> amount,
  Value<String?> description,
  Value<DateTime> txDate,
});

final class $$IncomeExpenseTableReferences extends BaseReferences<_$AppDatabase,
    $IncomeExpenseTable, IncomeExpenseData> {
  $$IncomeExpenseTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias(
          $_aliasNameGenerator(db.incomeExpense.projectId, db.projects.id));

  $$ProjectsTableProcessedTableManager? get projectId {
    final $_column = $_itemColumn<int>('project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager($_db, $_db.projects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EmployersTable _employerIdTable(_$AppDatabase db) =>
      db.employers.createAlias(
          $_aliasNameGenerator(db.incomeExpense.employerId, db.employers.id));

  $$EmployersTableProcessedTableManager? get employerId {
    final $_column = $_itemColumn<int>('employer_id');
    if ($_column == null) return null;
    final manager = $$EmployersTableTableManager($_db, $_db.employers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IncomeExpenseTableFilterComposer
    extends Composer<_$AppDatabase, $IncomeExpenseTable> {
  $$IncomeExpenseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get txDate => $composableBuilder(
      column: $table.txDate, builder: (column) => ColumnFilters(column));

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableFilterComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EmployersTableFilterComposer get employerId {
    final $$EmployersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employerId,
        referencedTable: $db.employers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployersTableFilterComposer(
              $db: $db,
              $table: $db.employers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncomeExpenseTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomeExpenseTable> {
  $$IncomeExpenseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get txDate => $composableBuilder(
      column: $table.txDate, builder: (column) => ColumnOrderings(column));

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableOrderingComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EmployersTableOrderingComposer get employerId {
    final $$EmployersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employerId,
        referencedTable: $db.employers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployersTableOrderingComposer(
              $db: $db,
              $table: $db.employers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncomeExpenseTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomeExpenseTable> {
  $$IncomeExpenseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get txDate =>
      $composableBuilder(column: $table.txDate, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EmployersTableAnnotationComposer get employerId {
    final $$EmployersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employerId,
        referencedTable: $db.employers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployersTableAnnotationComposer(
              $db: $db,
              $table: $db.employers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncomeExpenseTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IncomeExpenseTable,
    IncomeExpenseData,
    $$IncomeExpenseTableFilterComposer,
    $$IncomeExpenseTableOrderingComposer,
    $$IncomeExpenseTableAnnotationComposer,
    $$IncomeExpenseTableCreateCompanionBuilder,
    $$IncomeExpenseTableUpdateCompanionBuilder,
    (IncomeExpenseData, $$IncomeExpenseTableReferences),
    IncomeExpenseData,
    PrefetchHooks Function({bool projectId, bool employerId})> {
  $$IncomeExpenseTableTableManager(_$AppDatabase db, $IncomeExpenseTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomeExpenseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomeExpenseTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomeExpenseTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> projectId = const Value.absent(),
            Value<int?> employerId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> txDate = const Value.absent(),
          }) =>
              IncomeExpenseCompanion(
            id: id,
            projectId: projectId,
            employerId: employerId,
            type: type,
            category: category,
            amount: amount,
            description: description,
            txDate: txDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> projectId = const Value.absent(),
            Value<int?> employerId = const Value.absent(),
            required String type,
            required String category,
            required int amount,
            Value<String?> description = const Value.absent(),
            required DateTime txDate,
          }) =>
              IncomeExpenseCompanion.insert(
            id: id,
            projectId: projectId,
            employerId: employerId,
            type: type,
            category: category,
            amount: amount,
            description: description,
            txDate: txDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IncomeExpenseTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({projectId = false, employerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (projectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.projectId,
                    referencedTable:
                        $$IncomeExpenseTableReferences._projectIdTable(db),
                    referencedColumn:
                        $$IncomeExpenseTableReferences._projectIdTable(db).id,
                  ) as T;
                }
                if (employerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employerId,
                    referencedTable:
                        $$IncomeExpenseTableReferences._employerIdTable(db),
                    referencedColumn:
                        $$IncomeExpenseTableReferences._employerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IncomeExpenseTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IncomeExpenseTable,
    IncomeExpenseData,
    $$IncomeExpenseTableFilterComposer,
    $$IncomeExpenseTableOrderingComposer,
    $$IncomeExpenseTableAnnotationComposer,
    $$IncomeExpenseTableCreateCompanionBuilder,
    $$IncomeExpenseTableUpdateCompanionBuilder,
    (IncomeExpenseData, $$IncomeExpenseTableReferences),
    IncomeExpenseData,
    PrefetchHooks Function({bool projectId, bool employerId})>;
typedef $$DebtsTableCreateCompanionBuilder = DebtsCompanion Function({
  Value<int> id,
  required int employerId,
  Value<int?> projectId,
  required int amount,
  required DateTime borrowDate,
  required DateTime dueDate,
  Value<String> status,
  Value<String?> description,
  Value<DateTime> createdAt,
});
typedef $$DebtsTableUpdateCompanionBuilder = DebtsCompanion Function({
  Value<int> id,
  Value<int> employerId,
  Value<int?> projectId,
  Value<int> amount,
  Value<DateTime> borrowDate,
  Value<DateTime> dueDate,
  Value<String> status,
  Value<String?> description,
  Value<DateTime> createdAt,
});

final class $$DebtsTableReferences
    extends BaseReferences<_$AppDatabase, $DebtsTable, Debt> {
  $$DebtsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EmployersTable _employerIdTable(_$AppDatabase db) => db.employers
      .createAlias($_aliasNameGenerator(db.debts.employerId, db.employers.id));

  $$EmployersTableProcessedTableManager get employerId {
    final $_column = $_itemColumn<int>('employer_id')!;

    final manager = $$EmployersTableTableManager($_db, $_db.employers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProjectsTable _projectIdTable(_$AppDatabase db) => db.projects
      .createAlias($_aliasNameGenerator(db.debts.projectId, db.projects.id));

  $$ProjectsTableProcessedTableManager? get projectId {
    final $_column = $_itemColumn<int>('project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager($_db, $_db.projects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DebtPaymentsTable, List<DebtPayment>>
      _debtPaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.debtPayments,
          aliasName: $_aliasNameGenerator(db.debts.id, db.debtPayments.debtId));

  $$DebtPaymentsTableProcessedTableManager get debtPaymentsRefs {
    final manager = $$DebtPaymentsTableTableManager($_db, $_db.debtPayments)
        .filter((f) => f.debtId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtPaymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DebtsTableFilterComposer extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get borrowDate => $composableBuilder(
      column: $table.borrowDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$EmployersTableFilterComposer get employerId {
    final $$EmployersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employerId,
        referencedTable: $db.employers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployersTableFilterComposer(
              $db: $db,
              $table: $db.employers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableFilterComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> debtPaymentsRefs(
      Expression<bool> Function($$DebtPaymentsTableFilterComposer f) f) {
    final $$DebtPaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debtPayments,
        getReferencedColumn: (t) => t.debtId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtPaymentsTableFilterComposer(
              $db: $db,
              $table: $db.debtPayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get borrowDate => $composableBuilder(
      column: $table.borrowDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$EmployersTableOrderingComposer get employerId {
    final $$EmployersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employerId,
        referencedTable: $db.employers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployersTableOrderingComposer(
              $db: $db,
              $table: $db.employers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableOrderingComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get borrowDate => $composableBuilder(
      column: $table.borrowDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$EmployersTableAnnotationComposer get employerId {
    final $$EmployersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employerId,
        referencedTable: $db.employers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployersTableAnnotationComposer(
              $db: $db,
              $table: $db.employers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> debtPaymentsRefs<T extends Object>(
      Expression<T> Function($$DebtPaymentsTableAnnotationComposer a) f) {
    final $$DebtPaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debtPayments,
        getReferencedColumn: (t) => t.debtId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtPaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.debtPayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DebtsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DebtsTable,
    Debt,
    $$DebtsTableFilterComposer,
    $$DebtsTableOrderingComposer,
    $$DebtsTableAnnotationComposer,
    $$DebtsTableCreateCompanionBuilder,
    $$DebtsTableUpdateCompanionBuilder,
    (Debt, $$DebtsTableReferences),
    Debt,
    PrefetchHooks Function(
        {bool employerId, bool projectId, bool debtPaymentsRefs})> {
  $$DebtsTableTableManager(_$AppDatabase db, $DebtsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> employerId = const Value.absent(),
            Value<int?> projectId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<DateTime> borrowDate = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DebtsCompanion(
            id: id,
            employerId: employerId,
            projectId: projectId,
            amount: amount,
            borrowDate: borrowDate,
            dueDate: dueDate,
            status: status,
            description: description,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int employerId,
            Value<int?> projectId = const Value.absent(),
            required int amount,
            required DateTime borrowDate,
            required DateTime dueDate,
            Value<String> status = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DebtsCompanion.insert(
            id: id,
            employerId: employerId,
            projectId: projectId,
            amount: amount,
            borrowDate: borrowDate,
            dueDate: dueDate,
            status: status,
            description: description,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DebtsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {employerId = false,
              projectId = false,
              debtPaymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (debtPaymentsRefs) db.debtPayments],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employerId,
                    referencedTable:
                        $$DebtsTableReferences._employerIdTable(db),
                    referencedColumn:
                        $$DebtsTableReferences._employerIdTable(db).id,
                  ) as T;
                }
                if (projectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.projectId,
                    referencedTable: $$DebtsTableReferences._projectIdTable(db),
                    referencedColumn:
                        $$DebtsTableReferences._projectIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (debtPaymentsRefs)
                    await $_getPrefetchedData<Debt, $DebtsTable, DebtPayment>(
                        currentTable: table,
                        referencedTable:
                            $$DebtsTableReferences._debtPaymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DebtsTableReferences(db, table, p0)
                                .debtPaymentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.debtId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DebtsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DebtsTable,
    Debt,
    $$DebtsTableFilterComposer,
    $$DebtsTableOrderingComposer,
    $$DebtsTableAnnotationComposer,
    $$DebtsTableCreateCompanionBuilder,
    $$DebtsTableUpdateCompanionBuilder,
    (Debt, $$DebtsTableReferences),
    Debt,
    PrefetchHooks Function(
        {bool employerId, bool projectId, bool debtPaymentsRefs})>;
typedef $$DebtPaymentsTableCreateCompanionBuilder = DebtPaymentsCompanion
    Function({
  Value<int> id,
  required int debtId,
  required int amount,
  required DateTime paymentDate,
  Value<String?> note,
});
typedef $$DebtPaymentsTableUpdateCompanionBuilder = DebtPaymentsCompanion
    Function({
  Value<int> id,
  Value<int> debtId,
  Value<int> amount,
  Value<DateTime> paymentDate,
  Value<String?> note,
});

final class $$DebtPaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $DebtPaymentsTable, DebtPayment> {
  $$DebtPaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DebtsTable _debtIdTable(_$AppDatabase db) => db.debts
      .createAlias($_aliasNameGenerator(db.debtPayments.debtId, db.debts.id));

  $$DebtsTableProcessedTableManager get debtId {
    final $_column = $_itemColumn<int>('debt_id')!;

    final manager = $$DebtsTableTableManager($_db, $_db.debts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_debtIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DebtPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$DebtsTableFilterComposer get debtId {
    final $$DebtsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.debtId,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableFilterComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$DebtsTableOrderingComposer get debtId {
    final $$DebtsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.debtId,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableOrderingComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$DebtsTableAnnotationComposer get debtId {
    final $$DebtsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.debtId,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableAnnotationComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtPaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DebtPaymentsTable,
    DebtPayment,
    $$DebtPaymentsTableFilterComposer,
    $$DebtPaymentsTableOrderingComposer,
    $$DebtPaymentsTableAnnotationComposer,
    $$DebtPaymentsTableCreateCompanionBuilder,
    $$DebtPaymentsTableUpdateCompanionBuilder,
    (DebtPayment, $$DebtPaymentsTableReferences),
    DebtPayment,
    PrefetchHooks Function({bool debtId})> {
  $$DebtPaymentsTableTableManager(_$AppDatabase db, $DebtPaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> debtId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<DateTime> paymentDate = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              DebtPaymentsCompanion(
            id: id,
            debtId: debtId,
            amount: amount,
            paymentDate: paymentDate,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int debtId,
            required int amount,
            required DateTime paymentDate,
            Value<String?> note = const Value.absent(),
          }) =>
              DebtPaymentsCompanion.insert(
            id: id,
            debtId: debtId,
            amount: amount,
            paymentDate: paymentDate,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DebtPaymentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({debtId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (debtId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.debtId,
                    referencedTable:
                        $$DebtPaymentsTableReferences._debtIdTable(db),
                    referencedColumn:
                        $$DebtPaymentsTableReferences._debtIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DebtPaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DebtPaymentsTable,
    DebtPayment,
    $$DebtPaymentsTableFilterComposer,
    $$DebtPaymentsTableOrderingComposer,
    $$DebtPaymentsTableAnnotationComposer,
    $$DebtPaymentsTableCreateCompanionBuilder,
    $$DebtPaymentsTableUpdateCompanionBuilder,
    (DebtPayment, $$DebtPaymentsTableReferences),
    DebtPayment,
    PrefetchHooks Function({bool debtId})>;
typedef $$WorkersTableCreateCompanionBuilder = WorkersCompanion Function({
  Value<int> id,
  required String fullName,
  required int dailyRate,
  Value<String?> phone,
  Value<String?> note,
  Value<bool> active,
});
typedef $$WorkersTableUpdateCompanionBuilder = WorkersCompanion Function({
  Value<int> id,
  Value<String> fullName,
  Value<int> dailyRate,
  Value<String?> phone,
  Value<String?> note,
  Value<bool> active,
});

final class $$WorkersTableReferences
    extends BaseReferences<_$AppDatabase, $WorkersTable, Worker> {
  $$WorkersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkerAssignmentsTable, List<WorkerAssignment>>
      _workerAssignmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.workerAssignments,
              aliasName: $_aliasNameGenerator(
                  db.workers.id, db.workerAssignments.workerId));

  $$WorkerAssignmentsTableProcessedTableManager get workerAssignmentsRefs {
    final manager =
        $$WorkerAssignmentsTableTableManager($_db, $_db.workerAssignments)
            .filter((f) => f.workerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_workerAssignmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.payments,
          aliasName: $_aliasNameGenerator(db.workers.id, db.payments.workerId));

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager($_db, $_db.payments)
        .filter((f) => f.workerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkersTableFilterComposer
    extends Composer<_$AppDatabase, $WorkersTable> {
  $$WorkersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyRate => $composableBuilder(
      column: $table.dailyRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  Expression<bool> workerAssignmentsRefs(
      Expression<bool> Function($$WorkerAssignmentsTableFilterComposer f) f) {
    final $$WorkerAssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workerAssignments,
        getReferencedColumn: (t) => t.workerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkerAssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.workerAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> paymentsRefs(
      Expression<bool> Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.workerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkersTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkersTable> {
  $$WorkersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyRate => $composableBuilder(
      column: $table.dailyRate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));
}

class $$WorkersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkersTable> {
  $$WorkersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<int> get dailyRate =>
      $composableBuilder(column: $table.dailyRate, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  Expression<T> workerAssignmentsRefs<T extends Object>(
      Expression<T> Function($$WorkerAssignmentsTableAnnotationComposer a) f) {
    final $$WorkerAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.workerAssignments,
            getReferencedColumn: (t) => t.workerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WorkerAssignmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.workerAssignments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
      Expression<T> Function($$PaymentsTableAnnotationComposer a) f) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.workerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkersTable,
    Worker,
    $$WorkersTableFilterComposer,
    $$WorkersTableOrderingComposer,
    $$WorkersTableAnnotationComposer,
    $$WorkersTableCreateCompanionBuilder,
    $$WorkersTableUpdateCompanionBuilder,
    (Worker, $$WorkersTableReferences),
    Worker,
    PrefetchHooks Function({bool workerAssignmentsRefs, bool paymentsRefs})> {
  $$WorkersTableTableManager(_$AppDatabase db, $WorkersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<int> dailyRate = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> active = const Value.absent(),
          }) =>
              WorkersCompanion(
            id: id,
            fullName: fullName,
            dailyRate: dailyRate,
            phone: phone,
            note: note,
            active: active,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String fullName,
            required int dailyRate,
            Value<String?> phone = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> active = const Value.absent(),
          }) =>
              WorkersCompanion.insert(
            id: id,
            fullName: fullName,
            dailyRate: dailyRate,
            phone: phone,
            note: note,
            active: active,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WorkersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {workerAssignmentsRefs = false, paymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (workerAssignmentsRefs) db.workerAssignments,
                if (paymentsRefs) db.payments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workerAssignmentsRefs)
                    await $_getPrefetchedData<Worker, $WorkersTable,
                            WorkerAssignment>(
                        currentTable: table,
                        referencedTable: $$WorkersTableReferences
                            ._workerAssignmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkersTableReferences(db, table, p0)
                                .workerAssignmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.workerId == item.id),
                        typedResults: items),
                  if (paymentsRefs)
                    await $_getPrefetchedData<Worker, $WorkersTable, Payment>(
                        currentTable: table,
                        referencedTable:
                            $$WorkersTableReferences._paymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkersTableReferences(db, table, p0)
                                .paymentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.workerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkersTable,
    Worker,
    $$WorkersTableFilterComposer,
    $$WorkersTableOrderingComposer,
    $$WorkersTableAnnotationComposer,
    $$WorkersTableCreateCompanionBuilder,
    $$WorkersTableUpdateCompanionBuilder,
    (Worker, $$WorkersTableReferences),
    Worker,
    PrefetchHooks Function({bool workerAssignmentsRefs, bool paymentsRefs})>;
typedef $$WorkerAssignmentsTableCreateCompanionBuilder
    = WorkerAssignmentsCompanion Function({
  Value<int> id,
  required int workerId,
  required int projectId,
  required DateTime workDate,
  Value<int> hours,
  Value<int> overtimeHours,
});
typedef $$WorkerAssignmentsTableUpdateCompanionBuilder
    = WorkerAssignmentsCompanion Function({
  Value<int> id,
  Value<int> workerId,
  Value<int> projectId,
  Value<DateTime> workDate,
  Value<int> hours,
  Value<int> overtimeHours,
});

final class $$WorkerAssignmentsTableReferences extends BaseReferences<
    _$AppDatabase, $WorkerAssignmentsTable, WorkerAssignment> {
  $$WorkerAssignmentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WorkersTable _workerIdTable(_$AppDatabase db) =>
      db.workers.createAlias(
          $_aliasNameGenerator(db.workerAssignments.workerId, db.workers.id));

  $$WorkersTableProcessedTableManager get workerId {
    final $_column = $_itemColumn<int>('worker_id')!;

    final manager = $$WorkersTableTableManager($_db, $_db.workers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias(
          $_aliasNameGenerator(db.workerAssignments.projectId, db.projects.id));

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager($_db, $_db.projects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WorkerAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkerAssignmentsTable> {
  $$WorkerAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get workDate => $composableBuilder(
      column: $table.workDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hours => $composableBuilder(
      column: $table.hours, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get overtimeHours => $composableBuilder(
      column: $table.overtimeHours, builder: (column) => ColumnFilters(column));

  $$WorkersTableFilterComposer get workerId {
    final $$WorkersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workerId,
        referencedTable: $db.workers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkersTableFilterComposer(
              $db: $db,
              $table: $db.workers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableFilterComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkerAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkerAssignmentsTable> {
  $$WorkerAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get workDate => $composableBuilder(
      column: $table.workDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hours => $composableBuilder(
      column: $table.hours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get overtimeHours => $composableBuilder(
      column: $table.overtimeHours,
      builder: (column) => ColumnOrderings(column));

  $$WorkersTableOrderingComposer get workerId {
    final $$WorkersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workerId,
        referencedTable: $db.workers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkersTableOrderingComposer(
              $db: $db,
              $table: $db.workers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableOrderingComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkerAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkerAssignmentsTable> {
  $$WorkerAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get workDate =>
      $composableBuilder(column: $table.workDate, builder: (column) => column);

  GeneratedColumn<int> get hours =>
      $composableBuilder(column: $table.hours, builder: (column) => column);

  GeneratedColumn<int> get overtimeHours => $composableBuilder(
      column: $table.overtimeHours, builder: (column) => column);

  $$WorkersTableAnnotationComposer get workerId {
    final $$WorkersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workerId,
        referencedTable: $db.workers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkersTableAnnotationComposer(
              $db: $db,
              $table: $db.workers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkerAssignmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkerAssignmentsTable,
    WorkerAssignment,
    $$WorkerAssignmentsTableFilterComposer,
    $$WorkerAssignmentsTableOrderingComposer,
    $$WorkerAssignmentsTableAnnotationComposer,
    $$WorkerAssignmentsTableCreateCompanionBuilder,
    $$WorkerAssignmentsTableUpdateCompanionBuilder,
    (WorkerAssignment, $$WorkerAssignmentsTableReferences),
    WorkerAssignment,
    PrefetchHooks Function({bool workerId, bool projectId})> {
  $$WorkerAssignmentsTableTableManager(
      _$AppDatabase db, $WorkerAssignmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkerAssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkerAssignmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkerAssignmentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> workerId = const Value.absent(),
            Value<int> projectId = const Value.absent(),
            Value<DateTime> workDate = const Value.absent(),
            Value<int> hours = const Value.absent(),
            Value<int> overtimeHours = const Value.absent(),
          }) =>
              WorkerAssignmentsCompanion(
            id: id,
            workerId: workerId,
            projectId: projectId,
            workDate: workDate,
            hours: hours,
            overtimeHours: overtimeHours,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int workerId,
            required int projectId,
            required DateTime workDate,
            Value<int> hours = const Value.absent(),
            Value<int> overtimeHours = const Value.absent(),
          }) =>
              WorkerAssignmentsCompanion.insert(
            id: id,
            workerId: workerId,
            projectId: projectId,
            workDate: workDate,
            hours: hours,
            overtimeHours: overtimeHours,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkerAssignmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({workerId = false, projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workerId,
                    referencedTable:
                        $$WorkerAssignmentsTableReferences._workerIdTable(db),
                    referencedColumn: $$WorkerAssignmentsTableReferences
                        ._workerIdTable(db)
                        .id,
                  ) as T;
                }
                if (projectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.projectId,
                    referencedTable:
                        $$WorkerAssignmentsTableReferences._projectIdTable(db),
                    referencedColumn: $$WorkerAssignmentsTableReferences
                        ._projectIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WorkerAssignmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkerAssignmentsTable,
    WorkerAssignment,
    $$WorkerAssignmentsTableFilterComposer,
    $$WorkerAssignmentsTableOrderingComposer,
    $$WorkerAssignmentsTableAnnotationComposer,
    $$WorkerAssignmentsTableCreateCompanionBuilder,
    $$WorkerAssignmentsTableUpdateCompanionBuilder,
    (WorkerAssignment, $$WorkerAssignmentsTableReferences),
    WorkerAssignment,
    PrefetchHooks Function({bool workerId, bool projectId})>;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  required int workerId,
  Value<int?> projectId,
  required int amount,
  required DateTime paymentDate,
  required String method,
  Value<String?> note,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  Value<int> workerId,
  Value<int?> projectId,
  Value<int> amount,
  Value<DateTime> paymentDate,
  Value<String> method,
  Value<String?> note,
});

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkersTable _workerIdTable(_$AppDatabase db) => db.workers
      .createAlias($_aliasNameGenerator(db.payments.workerId, db.workers.id));

  $$WorkersTableProcessedTableManager get workerId {
    final $_column = $_itemColumn<int>('worker_id')!;

    final manager = $$WorkersTableTableManager($_db, $_db.workers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProjectsTable _projectIdTable(_$AppDatabase db) => db.projects
      .createAlias($_aliasNameGenerator(db.payments.projectId, db.projects.id));

  $$ProjectsTableProcessedTableManager? get projectId {
    final $_column = $_itemColumn<int>('project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager($_db, $_db.projects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$WorkersTableFilterComposer get workerId {
    final $$WorkersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workerId,
        referencedTable: $db.workers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkersTableFilterComposer(
              $db: $db,
              $table: $db.workers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableFilterComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$WorkersTableOrderingComposer get workerId {
    final $$WorkersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workerId,
        referencedTable: $db.workers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkersTableOrderingComposer(
              $db: $db,
              $table: $db.workers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableOrderingComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$WorkersTableAnnotationComposer get workerId {
    final $$WorkersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workerId,
        referencedTable: $db.workers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkersTableAnnotationComposer(
              $db: $db,
              $table: $db.workers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool workerId, bool projectId})> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> workerId = const Value.absent(),
            Value<int?> projectId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<DateTime> paymentDate = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              PaymentsCompanion(
            id: id,
            workerId: workerId,
            projectId: projectId,
            amount: amount,
            paymentDate: paymentDate,
            method: method,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int workerId,
            Value<int?> projectId = const Value.absent(),
            required int amount,
            required DateTime paymentDate,
            required String method,
            Value<String?> note = const Value.absent(),
          }) =>
              PaymentsCompanion.insert(
            id: id,
            workerId: workerId,
            projectId: projectId,
            amount: amount,
            paymentDate: paymentDate,
            method: method,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PaymentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({workerId = false, projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workerId,
                    referencedTable:
                        $$PaymentsTableReferences._workerIdTable(db),
                    referencedColumn:
                        $$PaymentsTableReferences._workerIdTable(db).id,
                  ) as T;
                }
                if (projectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.projectId,
                    referencedTable:
                        $$PaymentsTableReferences._projectIdTable(db),
                    referencedColumn:
                        $$PaymentsTableReferences._projectIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool workerId, bool projectId})>;
typedef $$WeeklySnapshotsTableCreateCompanionBuilder = WeeklySnapshotsCompanion
    Function({
  Value<int> id,
  required DateTime weekStart,
  required int incomeTotal,
  required int expenseTotal,
  required int debtTotal,
  required int payrollTotal,
  Value<DateTime> generatedAt,
});
typedef $$WeeklySnapshotsTableUpdateCompanionBuilder = WeeklySnapshotsCompanion
    Function({
  Value<int> id,
  Value<DateTime> weekStart,
  Value<int> incomeTotal,
  Value<int> expenseTotal,
  Value<int> debtTotal,
  Value<int> payrollTotal,
  Value<DateTime> generatedAt,
});

class $$WeeklySnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklySnapshotsTable> {
  $$WeeklySnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get incomeTotal => $composableBuilder(
      column: $table.incomeTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get expenseTotal => $composableBuilder(
      column: $table.expenseTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get debtTotal => $composableBuilder(
      column: $table.debtTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get payrollTotal => $composableBuilder(
      column: $table.payrollTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnFilters(column));
}

class $$WeeklySnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklySnapshotsTable> {
  $$WeeklySnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get incomeTotal => $composableBuilder(
      column: $table.incomeTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get expenseTotal => $composableBuilder(
      column: $table.expenseTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get debtTotal => $composableBuilder(
      column: $table.debtTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get payrollTotal => $composableBuilder(
      column: $table.payrollTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WeeklySnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklySnapshotsTable> {
  $$WeeklySnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<int> get incomeTotal => $composableBuilder(
      column: $table.incomeTotal, builder: (column) => column);

  GeneratedColumn<int> get expenseTotal => $composableBuilder(
      column: $table.expenseTotal, builder: (column) => column);

  GeneratedColumn<int> get debtTotal =>
      $composableBuilder(column: $table.debtTotal, builder: (column) => column);

  GeneratedColumn<int> get payrollTotal => $composableBuilder(
      column: $table.payrollTotal, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => column);
}

class $$WeeklySnapshotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeeklySnapshotsTable,
    WeeklySnapshot,
    $$WeeklySnapshotsTableFilterComposer,
    $$WeeklySnapshotsTableOrderingComposer,
    $$WeeklySnapshotsTableAnnotationComposer,
    $$WeeklySnapshotsTableCreateCompanionBuilder,
    $$WeeklySnapshotsTableUpdateCompanionBuilder,
    (
      WeeklySnapshot,
      BaseReferences<_$AppDatabase, $WeeklySnapshotsTable, WeeklySnapshot>
    ),
    WeeklySnapshot,
    PrefetchHooks Function()> {
  $$WeeklySnapshotsTableTableManager(
      _$AppDatabase db, $WeeklySnapshotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklySnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklySnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklySnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> weekStart = const Value.absent(),
            Value<int> incomeTotal = const Value.absent(),
            Value<int> expenseTotal = const Value.absent(),
            Value<int> debtTotal = const Value.absent(),
            Value<int> payrollTotal = const Value.absent(),
            Value<DateTime> generatedAt = const Value.absent(),
          }) =>
              WeeklySnapshotsCompanion(
            id: id,
            weekStart: weekStart,
            incomeTotal: incomeTotal,
            expenseTotal: expenseTotal,
            debtTotal: debtTotal,
            payrollTotal: payrollTotal,
            generatedAt: generatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime weekStart,
            required int incomeTotal,
            required int expenseTotal,
            required int debtTotal,
            required int payrollTotal,
            Value<DateTime> generatedAt = const Value.absent(),
          }) =>
              WeeklySnapshotsCompanion.insert(
            id: id,
            weekStart: weekStart,
            incomeTotal: incomeTotal,
            expenseTotal: expenseTotal,
            debtTotal: debtTotal,
            payrollTotal: payrollTotal,
            generatedAt: generatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeeklySnapshotsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeeklySnapshotsTable,
    WeeklySnapshot,
    $$WeeklySnapshotsTableFilterComposer,
    $$WeeklySnapshotsTableOrderingComposer,
    $$WeeklySnapshotsTableAnnotationComposer,
    $$WeeklySnapshotsTableCreateCompanionBuilder,
    $$WeeklySnapshotsTableUpdateCompanionBuilder,
    (
      WeeklySnapshot,
      BaseReferences<_$AppDatabase, $WeeklySnapshotsTable, WeeklySnapshot>
    ),
    WeeklySnapshot,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EmployersTableTableManager get employers =>
      $$EmployersTableTableManager(_db, _db.employers);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$IncomeExpenseTableTableManager get incomeExpense =>
      $$IncomeExpenseTableTableManager(_db, _db.incomeExpense);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db, _db.debts);
  $$DebtPaymentsTableTableManager get debtPayments =>
      $$DebtPaymentsTableTableManager(_db, _db.debtPayments);
  $$WorkersTableTableManager get workers =>
      $$WorkersTableTableManager(_db, _db.workers);
  $$WorkerAssignmentsTableTableManager get workerAssignments =>
      $$WorkerAssignmentsTableTableManager(_db, _db.workerAssignments);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$WeeklySnapshotsTableTableManager get weeklySnapshots =>
      $$WeeklySnapshotsTableTableManager(_db, _db.weeklySnapshots);
}

mixin _$EmployerDaoMixin on DatabaseAccessor<AppDatabase> {
  $EmployersTable get employers => attachedDatabase.employers;
}
mixin _$ProjectDaoMixin on DatabaseAccessor<AppDatabase> {
  $EmployersTable get employers => attachedDatabase.employers;
  $ProjectsTable get projects => attachedDatabase.projects;
}
mixin _$FinanceDaoMixin on DatabaseAccessor<AppDatabase> {
  $EmployersTable get employers => attachedDatabase.employers;
  $ProjectsTable get projects => attachedDatabase.projects;
  $IncomeExpenseTable get incomeExpense => attachedDatabase.incomeExpense;
}
mixin _$DebtDaoMixin on DatabaseAccessor<AppDatabase> {
  $EmployersTable get employers => attachedDatabase.employers;
  $ProjectsTable get projects => attachedDatabase.projects;
  $DebtsTable get debts => attachedDatabase.debts;
  $DebtPaymentsTable get debtPayments => attachedDatabase.debtPayments;
}
mixin _$WorkerDaoMixin on DatabaseAccessor<AppDatabase> {
  $WorkersTable get workers => attachedDatabase.workers;
  $EmployersTable get employers => attachedDatabase.employers;
  $ProjectsTable get projects => attachedDatabase.projects;
  $WorkerAssignmentsTable get workerAssignments =>
      attachedDatabase.workerAssignments;
  $PaymentsTable get payments => attachedDatabase.payments;
}
mixin _$ReportDaoMixin on DatabaseAccessor<AppDatabase> {
  $WeeklySnapshotsTable get weeklySnapshots => attachedDatabase.weeklySnapshots;
}
