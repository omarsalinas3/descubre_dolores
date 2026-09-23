import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entities/lugar_turistico.dart';
import '../viewmodels/detalle_view_model.dart';

class DetalleLugarScreen extends StatefulWidget {
  final LugarTuristico lugar;
  const DetalleLugarScreen({super.key, required this.lugar});

  @override
  State<DetalleLugarScreen> createState() => _DetalleLugarScreenState();
}

class _DetalleLugarScreenState extends State<DetalleLugarScreen> {
  late final DetalleViewModel _viewModel;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _viewModel = DetalleViewModel(widget.lugar);
    final video = widget.lugar.videoAsset;
    if (video != null) {
      _videoController = VideoPlayerController.asset(video)
        ..initialize().then((_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lugar.nombre),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              // Imagen principal con efecto Hero y sombra
              Hero(
                tag: 'lugar-img-${widget.lugar.id}',
                child: Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      widget.lugar.imagenAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image, size: 64, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título y categoría
                    Row(
                      children: [
                        const Icon(Icons.museum_outlined, color: Color(0xFF7A2E1D), size: 20),
                        const SizedBox(width: 6),
                        Text(
                          'SITIO HISTÓRICO PATRIMONIAL',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: const Color(0xD97A2E1D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.lugar.nombre,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tarjeta de Descripción
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          widget.lugar.descripcion,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tarjeta de Audio-guía
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.headphones_rounded, color: Color(0xFF7A2E1D)),
                                SizedBox(width: 8),
                                Text(
                                  'Audio-guía Narrada',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E1E1E),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Escucha la narración histórica detallada de este lugar emblemático.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 14),
                            AnimatedBuilder(
                              animation: _viewModel,
                              builder: (context, _) => SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton.icon(
                                  onPressed: _viewModel.alternarAudio,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _viewModel.reproduciendo
                                        ? const Color(0xFFB45309)
                                        : const Color(0xFF7A2E1D),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  icon: Icon(
                                    _viewModel.reproduciendo
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_filled,
                                    size: 24,
                                  ),
                                  label: Text(
                                    _viewModel.reproduciendo
                                        ? 'Pausar audio-guía'
                                        : 'Escuchar audio-guía',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Sección de Video (si existe)
                    if (_videoController != null &&
                        _videoController!.value.isInitialized) ...[
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.video_library_rounded, color: Color(0xFFB45309)),
                                  SizedBox(width: 8),
                                  Text(
                                    'Recorrido en Video',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: _videoController!.value.aspectRatio,
                                      child: VideoPlayer(_videoController!),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          _videoController!.value.isPlaying
                                              ? Icons.pause_circle_filled
                                              : Icons.play_circle_filled,
                                          color: Colors.white,
                                        ),
                                        iconSize: 56,
                                        onPressed: () {
                                          setState(() {
                                            _videoController!.value.isPlaying
                                                ? _videoController!.pause()
                                                : _videoController!.play();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
