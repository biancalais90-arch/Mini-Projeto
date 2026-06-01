final List<Map<String, dynamic>> dadosTarefas = [
  {
    'id': 1,
    'titulo': ' Corrigir bug login ',
    'responsavel': 'Ana',
    'status': 'concluida',
    'prioridade': 'alta',
    'valor': 'R\$ 120,00',
    'horas': '2',
  },
  {
    'id': 2,
    'titulo': 'Criar tela de perfil',
    'responsavel': ' Bruno ',
    'status': 'em andamento',
    'prioridade': 'media',
    'valor': 'R\$ 250,50',
    'horas': '5',
  },
  {
    'id': 3,
    'titulo': null,
    'responsavel': 'Carla',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 80,00',
    'horas': null,
  },
  {
    'id': 4,
    'titulo': ' Ajustar navegação ',
    'responsavel': null,
    'status': 'concluida',
    'prioridade': 'alta',
    'valor': 'R\$ 150,75',
    'horas': '3',
  },
  {
    'id': 5,
    'titulo': 'Revisar regras de negócio',
    'responsavel': 'Daniel',
    'status': 'cancelada',
    'prioridade': 'media',
    'valor': 'R\$ 0,00',
    'horas': '0',
  },
  {
    'id': 6,
    'titulo': 'Implementar validação de dados',
    'responsavel': 'Eduarda',
    'status': 'concluida',
    'prioridade': 'alta',
    'valor': 'R\$ 200,00',
    'horas': '4',
  },
  {
    'id': 7,
    'titulo': 'Organizar documentação',
    'responsavel': 'Felipe',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 90,00',
    'horas': '2',
  },
];

class ItemTrabalho {
  int id;
  String titulo;

  ItemTrabalho({required this.id, required this.titulo});

  void exibirResumo() {
    print('Item $id - $titulo');
  }
}

class Tarefa extends ItemTrabalho {
  String responsavel;
  String status;
  String prioridade;
  double valor;
  int horas;

  Tarefa({
    required int id,
    required String titulo,
    required this.responsavel,
    required this.status,
    required this.prioridade,
    required this.valor,
    required this.horas,
  }) : super(id: id, titulo: titulo);

  @override
  void exibirResumo() {
    print('Tarefa $id - $titulo | Status: $status | Valor: R\$ $valor');
  }

  Tarefa.fromMap(Map<String, dynamic> map)
    : responsavel = map['responsavel']?.toString().trim() ?? 'Não informado',
      status = map['status']?.toString().trim() ?? 'sem status',
      prioridade = map['prioridade'] ?? 'sem prioridade',
      valor = double.parse(
        map['valor']
            .toString()
            .replaceAll('R\$ ', '')
            .trim()
            .replaceAll(',', '.'),
      ),
      horas = int.parse(map['horas']?.toString() ?? '0'),
      super(
        id: map['id'] ?? 0,
        titulo: map['titulo']?.toString().trim() ?? 'Sem título',
      );
}

class RelatorioTarefas {
  final List<Tarefa> _tarefas;

  RelatorioTarefas(List<Tarefa> tarefas) : _tarefas = tarefas;

  int get quantidadeTotal => _tarefas.length;
}

void main() {
  List<Tarefa> tarefas = dadosTarefas
      .map((item) => Tarefa.fromMap(item))
      .toList();

  print('\nTAREFAS CONVERTIDAS:\n');

  for (var tarefa in tarefas) {
    print('ID: ${tarefa.id}');
    print('Título: ${tarefa.titulo}');
    print('Responsável: ${tarefa.responsavel}');
    print('Status: ${tarefa.status}');
    print('Prioridade: ${tarefa.prioridade}');
    print('Valor: R\$ ${tarefa.valor}');
    print('Horas: ${tarefa.horas}');
  }

  print('Status encontrados:');
  Set<String> statusUnicos = tarefas.map((tarefa) => tarefa.status).toSet();
  for (var status in statusUnicos) {
    print(status);
  }

  RelatorioTarefas relatorio = RelatorioTarefas(tarefas);

  print('\nQuantidade total de tarefas:');
  print(relatorio.quantidadeTotal);

  print('\nTarefas concluídas:');

  for (var tarefa in tarefas) {
    if (tarefa.status == 'concluida') {
      print('- ${tarefa.titulo}');
    }
  }

  double totalConcluidas = 0;

  for (var tarefa in tarefas) {
    if (tarefa.status == 'concluida') {
      totalConcluidas += tarefa.valor;
    }
  }

  print('\nTotal de Tarefas concluídas: R\$ $totalConcluidas');

  double somaPendentes = 0;
  int qtdPendentes = 0;

  for (var tarefa in tarefas) {
    if (tarefa.status == 'pendente') {
      somaPendentes += tarefa.valor;
      qtdPendentes++;
    }
  }

  Map<String, int> horasPorStatus = {};

  for (var tarefa in tarefas) {
    horasPorStatus[tarefa.status] =
        (horasPorStatus[tarefa.status] ?? 0) + tarefa.horas;
  }

  horasPorStatus.forEach((status, horas) {});

  print('\nStatus encontrados:');

  for (var status in statusUnicos) {
    print(status);
  }

  print('\nTarefas com dados incompletos:');

  for (var item in dadosTarefas) {
    if (item['titulo'] == null ||
        item['responsavel'] == null ||
        item['horas'] == null ||
        item['status'] == null ||
        item['status'].toString().trim().isEmpty) {
      print(
        'ID ${item['id']} - ${item['titulo']?.toString().trim() ?? 'Sem título'}',
      );
    }
  }

  print('RELATÓRIO FINAL DE TAREFAS');

  int concluidas = 0;
  int pendentes = 0;
  int emAndamento = 0;
  int canceladas = 0;
  int horasConcluidas = 0;

  for (var tarefa in tarefas) {
    if (tarefa.status == 'concluida') {
      concluidas++;
      horasConcluidas += tarefa.horas;
    } else if (tarefa.status == 'pendente') {
      pendentes++;
    } else if (tarefa.status == 'em andamento') {
      emAndamento++;
    } else if (tarefa.status == 'cancelada') {
      canceladas++;
    }
  }

  double mediaPendentes = qtdPendentes > 0 ? somaPendentes / qtdPendentes : 0;

  print('\nTotal de tarefas analisadas: ${tarefas.length}');
  print('Tarefas concluídas: $concluidas');
  print('Tarefas pendentes: $pendentes');
  print('Tarefas em andamento: $emAndamento');
  print('Tarefas canceladas: $canceladas');

  print(
    '\nValor total das concluídas: R\$ ${totalConcluidas.toStringAsFixed(2)}',
  );

  print(
    'Média de valor das pendentes: R\$ ${mediaPendentes.toStringAsFixed(2)}',
  );

  print('Total de horas concluídas: $horasConcluidas');

  //esqueci de commita durante o projeto estou aprendendo.
}


