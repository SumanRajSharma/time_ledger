import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_state.dart';
import 'package:time_ledger/features/clients/presentation/bloc/get_clients_bloc.dart';
import 'package:time_ledger/features/clients/presentation/bloc/get_clients_event.dart';
import 'package:time_ledger/features/clients/presentation/bloc/get_clients_state.dart';
import 'package:time_ledger/features/clients/presentation/bloc/search_client_bloc.dart';
import 'package:time_ledger/features/clients/presentation/bloc/search_client_event.dart';
import 'package:time_ledger/features/clients/presentation/bloc/search_client_state.dart';
import 'package:time_ledger/features/clients/presentation/pages/create_client_screen.dart';
import 'package:time_ledger/features/clients/presentation/widgets/clients_screen/clients_list_view.dart';
import 'package:time_ledger/features/clients/presentation/widgets/clients_screen/client_search_bar.dart';
import 'package:time_ledger/injection_container.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final manageAuth = sl<ManageAuthentication>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(const CheckSession()),
        ),
        BlocProvider<GetClientsBloc>(
          create: (context) => sl<GetClientsBloc>(),
        ),
        BlocProvider<SearchClientBloc>(
          create: (context) => sl<SearchClientBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Clients',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Iconsax.add),
              onPressed: () {
                showMaterialModalBottomSheet(
                  expand: true,
                  context: context,
                  builder: (context) => CreateClientScreen(),
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: BlocBuilder<SearchClientBloc, SearchClientState>(
              builder: (context, state) {
                return ClientSearchBar(
                  searchController: _searchController,
                  onSearchChanged: (query) {
                    context
                        .read<SearchClientBloc>()
                        .add(SearchQueryChanged(query));
                  },
                );
              },
            ),
          ),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              BlocProvider.of<GetClientsBloc>(context)
                  .add(const FetchClients());
            } else if (state is Unauthenticated) {
              context.loaderOverlay.hide();
              manageAuth.logout();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Logout successful. Your session has ended. Come back anytime!'),
                ),
              );
              manageAuth.logout();
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AuthLoading) {
              context.loaderOverlay.show(progress: 'Signing Out..');
            }
          },
          builder: (context, authState) {
            if (authState is Authenticated) {
              return BlocBuilder<GetClientsBloc, GetClientsState>(
                builder: (context, clientState) {
                  if (clientState is GetClientsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (clientState is GetClientsLoaded) {
                    BlocProvider.of<SearchClientBloc>(context)
                        .add(InitializeSearch(clientState.clients));
                    return BlocBuilder<SearchClientBloc, SearchClientState>(
                      builder: (context, searchState) {
                        if (searchState is SearchClientLoaded) {
                          return ClientsListView(
                            clients: searchState.filteredClients,
                            onRefresh: () async {
                              BlocProvider.of<GetClientsBloc>(context)
                                  .add(const FetchClients());
                            },
                          );
                        } else if (searchState is SearchClientError) {
                          return Center(
                              child: Text('Error: ${searchState.message}'));
                        } else {
                          return const Center(
                              child: Text('No clients data found.'));
                        }
                      },
                    );
                  } else if (clientState is GetClientsError) {
                    return Center(child: Text('Error: ${clientState.message}'));
                  } else {
                    return const Center(child: Text('No clients data found.'));
                  }
                },
              );
            } else {
              return const Center(
                child: Text('Please log in to see your profile information.'),
              );
            }
          },
        ),
      ),
    );
  }
}
