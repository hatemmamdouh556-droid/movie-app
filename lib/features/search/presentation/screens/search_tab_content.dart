part of 'search_tab.dart';

class _SearchTabContent extends StatefulWidget {
  const _SearchTabContent();

  @override
  State<_SearchTabContent> createState() => _SearchTabContentState();
}

class _SearchTabContentState extends State<_SearchTabContent> {
  static const _debounceDuration = Duration(milliseconds: 400);

  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(
      _debounceDuration,
      () => context.read<SearchViewModel>().search(value),
    );
    setState(() {});
  }

  void _submitSearch(String value) {
    _debounce?.cancel();
    context.read<SearchViewModel>().search(value);
    FocusScope.of(context).unfocus();
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchController.clear();
    context.read<SearchViewModel>().search('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Text(l10n.searchTitle, style: AppStyles.bold24White),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onChanged: _onSearchChanged,
            onSubmitted: _submitSearch,
            style: AppStyles.white16,
            decoration: InputDecoration(
              hintText: l10n.searchHint,
              hintStyle: AppStyles.white14.copyWith(color: AppColors.grayColor),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: l10n.searchClear,
                      onPressed: _clearSearch,
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.whiteColor,
                      ),
                    ),
              filled: true,
              fillColor: AppColors.fieldColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: BlocBuilder<SearchViewModel, SearchStats>(
            builder: (context, state) => switch (state) {
              SearchInitialStats() => SearchMessage(
                icon: Icons.movie_filter_outlined,
                message: l10n.searchPrompt,
              ),
              SearchLoadingStats() => const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
              SearchEmptyStats() => SearchMessage(
                icon: Icons.movie_creation_outlined,
                message: l10n.searchNoResults,
              ),
              SearchErrorStats() => SearchError(
                message: l10n.searchError,
                retryLabel: l10n.searchTryAgain,
                onRetry: () => context.read<SearchViewModel>().retry(),
              ),
              SearchSuccessStats(:final movies) => SearchResults(
                movies: movies,
              ),
            },
          ),
        ),
      ],
    );
  }
}
