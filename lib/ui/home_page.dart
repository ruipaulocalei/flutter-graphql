import 'package:flutter/material.dart';
import 'package:flutter_graphql_crud/models/project_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String projectsQuery = """
    query {
      projects {
        id
        title
        description
        }
      }
    """;
    return Scaffold(
        appBar: AppBar(title: const Text('Projects')),
        body: Query(
            options: QueryOptions(document: gql(projectsQuery)),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              // it can be either Map or List
              List projects = result.data!['projects'];
              final projectList =
                  projects.map((e) => Projects.fromJson(e)).toList();

              return projectList.isNotEmpty
                  ? ListView.builder(
                      itemCount: projectList.length,
                      itemBuilder: (context, index) {
                        final project = projectList[index];

                        return Card(
                          elevation: 8,
                          child: ListTile(
                            title: Text(
                              project.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              project.description,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // trailing: Expanded(
                            //   child: Row(
                            //     children: [
                            //       InkWell(
                            //         child: Icon(Icons.edit),
                            //         onTap: () {},
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ),
                        );
                      })
                  : Container(
                      child: Center(
                        child: Text('No projects. Create One'),
                      ),
                    );
            }));
  }
}
