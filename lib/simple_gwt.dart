/// SimpleGWT support Given When Then style testing.
///
/// First, you wrap a test body by [gwt] or [gwt_] method. [gwt] method is for unit testing. [gwt_] method is also for widget testing.
/// Second, you write test code with [given], [when], [then], and [and] methods.
/// And, you run tests.
library simple_gwt;

export 'src/given_when_then.dart';
export 'src/gwt.dart';
