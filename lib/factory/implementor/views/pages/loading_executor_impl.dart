import 'package:flutter/material.dart';
import 'package:spisyprovider/views/Page/loading_page/loading_executor.dart';

class LoadingExecutorImpl implements LoadingExecutor{
  
  VoidCallback? exec;

  @override
  VoidCallback? get execute => exec;
}