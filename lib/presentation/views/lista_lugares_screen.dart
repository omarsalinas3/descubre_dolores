import 'package:flutter/material.dart';
import '../viewmodels/lugares_view_model.dart';
import 'detalle_lugar_screen.dart';

class ListaLugaresScreen extends StatefulWidget {
  final LugaresViewModel viewModel;
  const ListaLugaresScreen({super.key, required this.viewModel});

  @override
  State<ListaLugaresScreen> createState() => _ListaLugaresScreenState();
}

class _ListaLugaresScreenState extends State<ListaLugaresScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.cargar();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, _) {
        if (widget.viewModel.cargando) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF7A2E1D)),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, size: 22),
                SizedBox(width: 8),
                Text('Descubre Dolores Hidalgo'),
              ],
            ),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 750),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                children: [
                  // Banner de encabezado
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7A2E1D), Color(0xFFB45309)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cuna de la Independencia Nacional 🇲🇽',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Guía Multimedia de Sitios Históricos',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Explora fotografías, narraciones de audio-guía y videos de los lugares más emblemáticos.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Lista de lugares con tarjetas modernas
                  ...List.generate(widget.viewModel.lugares.length, (i) {
                    final lugar = widget.viewModel.lugares[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DetalleLugarScreen(lugar: lugar),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Hero(
                                tag: 'lugar-img-${lugar.id}',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    lugar.imagenAsset,
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, stack) => Container(
                                      width: 90,
                                      height: 90,
                                      color: Colors.grey.shade300,
                                      child: const Icon(Icons.image, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lugar.nombre,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2D2A26),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      lugar.descripcion,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700,
                                        height: 1.3,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF3E8E2),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.headphones,
                                                  size: 13, color: Color(0xFF7A2E1D)),
                                              SizedBox(width: 4),
                                              Text(
                                                'Audio-guía',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF7A2E1D),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (lugar.videoAsset != null) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFEF3C7),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.videocam,
                                                    size: 13, color: Color(0xFFB45309)),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Video',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFB45309),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
