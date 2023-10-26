// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'new_page_model.dart';
// export 'new_page_model.dart';

// class NewPageWidget extends StatefulWidget {
//   const NewPageWidget({Key? key}) : super(key: key);

//   @override
//   _NewPageWidgetState createState() => _NewPageWidgetState();
// }

// class _NewPageWidgetState extends State<NewPageWidget> {
//   late NewPageModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => NewPageModel());
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         body: SafeArea(
//           top: true,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Container(
//                   height: 200,
//                   child: Stack(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 140,
//                         decoration: BoxDecoration(
//                           color:
//                               FlutterFlowTheme.of(context).secondaryBackground,
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: Image.network(
//                               'https://images.unsplash.com/photo-1453025751787-45fc5af8c98c?w=1280&h=720',
//                             ).image,
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: AlignmentDirectional(-1.00, 1.00),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 16),
//                           child: Container(
//                             width: 90,
//                             height: 90,
//                             decoration: BoxDecoration(
//                               color: FlutterFlowTheme.of(context).accent1,
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: FlutterFlowTheme.of(context).primary,
//                                 width: 2,
//                               ),
//                             ),
//                             child: Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(50),
//                                 child: Image.network(
//                                   'https://images.unsplash.com/photo-1531037000883-3ae357a3eebf?w=1280&h=720',
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
//                   child: Text(
//                     'Andrew D.',
//                     style: FlutterFlowTheme.of(context).headlineSmall,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 16),
//                   child: Text(
//                     'andrew@domainname.com',
//                     style: FlutterFlowTheme.of(context).labelLarge,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
//                   child: Text(
//                     'Your Account',
//                     style: FlutterFlowTheme.of(context).labelMedium,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
//                   child: Material(
//                     color: Colors.transparent,
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Container(
//                       width: double.infinity,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: FlutterFlowTheme.of(context).secondaryBackground,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       alignment: AlignmentDirectional(0.00, 0.00),
//                       child: Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Icon(
//                               Icons.account_circle_outlined,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                               size: 24,
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                               child: Text(
//                                 'Edit Profile',
//                                 style: FlutterFlowTheme.of(context).labelMedium,
//                               ),
//                             ),
//                             Expanded(
//                               child: Align(
//                                 alignment: AlignmentDirectional(0.90, 0.00),
//                                 child: Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryText,
//                                   size: 18,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
//                   child: Material(
//                     color: Colors.transparent,
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Container(
//                       width: double.infinity,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: FlutterFlowTheme.of(context).secondaryBackground,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       alignment: AlignmentDirectional(0.00, 0.00),
//                       child: Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Icon(
//                               Icons.notifications_none,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                               size: 24,
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                               child: Text(
//                                 'Notification Settings',
//                                 style: FlutterFlowTheme.of(context).labelMedium,
//                               ),
//                             ),
//                             Expanded(
//                               child: Align(
//                                 alignment: AlignmentDirectional(0.90, 0.00),
//                                 child: Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryText,
//                                   size: 18,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(24, 16, 0, 0),
//                   child: Text(
//                     'App Settings',
//                     style: FlutterFlowTheme.of(context).labelMedium,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
//                   child: Material(
//                     color: Colors.transparent,
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Container(
//                       width: double.infinity,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: FlutterFlowTheme.of(context).secondaryBackground,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       alignment: AlignmentDirectional(0.00, 0.00),
//                       child: Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Icon(
//                               Icons.help_outline_rounded,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                               size: 24,
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                               child: Text(
//                                 'Support',
//                                 style: FlutterFlowTheme.of(context).labelMedium,
//                               ),
//                             ),
//                             Expanded(
//                               child: Align(
//                                 alignment: AlignmentDirectional(0.90, 0.00),
//                                 child: Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryText,
//                                   size: 18,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
//                   child: Material(
//                     color: Colors.transparent,
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Container(
//                       width: double.infinity,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: FlutterFlowTheme.of(context).secondaryBackground,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       alignment: AlignmentDirectional(0.00, 0.00),
//                       child: Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Icon(
//                               Icons.privacy_tip_rounded,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                               size: 24,
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                               child: Text(
//                                 'Terms of Service',
//                                 style: FlutterFlowTheme.of(context).labelMedium,
//                               ),
//                             ),
//                             Expanded(
//                               child: Align(
//                                 alignment: AlignmentDirectional(0.90, 0.00),
//                                 child: Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryText,
//                                   size: 18,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(0.00, 0.00),
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
//                     child: FFButtonWidget(
//                       onPressed: () {
//                         print('Button pressed ...');
//                       },
//                       text: 'Log Out',
//                       options: FFButtonOptions(
//                         width: 150,
//                         height: 44,
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                         iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                         color: FlutterFlowTheme.of(context).primaryBackground,
//                         textStyle: FlutterFlowTheme.of(context).labelLarge,
//                         elevation: 0,
//                         borderSide: BorderSide(
//                           color: Color(0x00000000),
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(38),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
