import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(ecoCycleStoreProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('ECOmmunity')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
        children: [
          EcoSurfaceCard(
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Bagikan kegiatan ramah lingkungan hari ini...',
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () async {
                      await ref
                          .read(communityRepositoryProvider)
                          .addCommunityPost(_controller.text);
                      _controller.clear();
                    },
                    child: const Text('Publikasikan'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...store.posts.map(
            (post) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EcoSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(child: Icon(Icons.park_outlined)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.author,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text('${post.location} • ${formatShortDate(post.sync.createdAt)}'),
                            ],
                          ),
                        ),
                        InfoPill(label: syncStatusLabel(post.sync.syncStatus)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(post.content),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Icon(Icons.favorite_border_rounded, size: 18),
                        const SizedBox(width: 6),
                        Text('${post.likes} suka'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
