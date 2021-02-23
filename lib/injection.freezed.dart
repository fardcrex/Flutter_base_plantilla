// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'injection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$EnvTearOff {
  const _$EnvTearOff();

// ignore: unused_element
  Dev dev() {
    return const Dev();
  }

// ignore: unused_element
  Prod prod() {
    return const Prod();
  }

// ignore: unused_element
  Test test() {
    return const Test();
  }
}

/// @nodoc
// ignore: unused_element
const $Env = _$EnvTearOff();

/// @nodoc
mixin _$Env {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult dev(),
    @required TResult prod(),
    @required TResult test(),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult dev(),
    TResult prod(),
    TResult test(),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult dev(Dev value),
    @required TResult prod(Prod value),
    @required TResult test(Test value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult dev(Dev value),
    TResult prod(Prod value),
    TResult test(Test value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $EnvCopyWith<$Res> {
  factory $EnvCopyWith(Env value, $Res Function(Env) then) =
      _$EnvCopyWithImpl<$Res>;
}

/// @nodoc
class _$EnvCopyWithImpl<$Res> implements $EnvCopyWith<$Res> {
  _$EnvCopyWithImpl(this._value, this._then);

  final Env _value;
  // ignore: unused_field
  final $Res Function(Env) _then;
}

/// @nodoc
abstract class $DevCopyWith<$Res> {
  factory $DevCopyWith(Dev value, $Res Function(Dev) then) =
      _$DevCopyWithImpl<$Res>;
}

/// @nodoc
class _$DevCopyWithImpl<$Res> extends _$EnvCopyWithImpl<$Res>
    implements $DevCopyWith<$Res> {
  _$DevCopyWithImpl(Dev _value, $Res Function(Dev) _then)
      : super(_value, (v) => _then(v as Dev));

  @override
  Dev get _value => super._value as Dev;
}

/// @nodoc
class _$Dev implements Dev {
  const _$Dev();

  @override
  String toString() {
    return 'Env.dev()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Dev);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult dev(),
    @required TResult prod(),
    @required TResult test(),
  }) {
    assert(dev != null);
    assert(prod != null);
    assert(test != null);
    return dev();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult dev(),
    TResult prod(),
    TResult test(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (dev != null) {
      return dev();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult dev(Dev value),
    @required TResult prod(Prod value),
    @required TResult test(Test value),
  }) {
    assert(dev != null);
    assert(prod != null);
    assert(test != null);
    return dev(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult dev(Dev value),
    TResult prod(Prod value),
    TResult test(Test value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (dev != null) {
      return dev(this);
    }
    return orElse();
  }
}

abstract class Dev implements Env {
  const factory Dev() = _$Dev;
}

/// @nodoc
abstract class $ProdCopyWith<$Res> {
  factory $ProdCopyWith(Prod value, $Res Function(Prod) then) =
      _$ProdCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProdCopyWithImpl<$Res> extends _$EnvCopyWithImpl<$Res>
    implements $ProdCopyWith<$Res> {
  _$ProdCopyWithImpl(Prod _value, $Res Function(Prod) _then)
      : super(_value, (v) => _then(v as Prod));

  @override
  Prod get _value => super._value as Prod;
}

/// @nodoc
class _$Prod implements Prod {
  const _$Prod();

  @override
  String toString() {
    return 'Env.prod()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Prod);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult dev(),
    @required TResult prod(),
    @required TResult test(),
  }) {
    assert(dev != null);
    assert(prod != null);
    assert(test != null);
    return prod();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult dev(),
    TResult prod(),
    TResult test(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (prod != null) {
      return prod();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult dev(Dev value),
    @required TResult prod(Prod value),
    @required TResult test(Test value),
  }) {
    assert(dev != null);
    assert(prod != null);
    assert(test != null);
    return prod(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult dev(Dev value),
    TResult prod(Prod value),
    TResult test(Test value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (prod != null) {
      return prod(this);
    }
    return orElse();
  }
}

abstract class Prod implements Env {
  const factory Prod() = _$Prod;
}

/// @nodoc
abstract class $TestCopyWith<$Res> {
  factory $TestCopyWith(Test value, $Res Function(Test) then) =
      _$TestCopyWithImpl<$Res>;
}

/// @nodoc
class _$TestCopyWithImpl<$Res> extends _$EnvCopyWithImpl<$Res>
    implements $TestCopyWith<$Res> {
  _$TestCopyWithImpl(Test _value, $Res Function(Test) _then)
      : super(_value, (v) => _then(v as Test));

  @override
  Test get _value => super._value as Test;
}

/// @nodoc
class _$Test implements Test {
  const _$Test();

  @override
  String toString() {
    return 'Env.test()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Test);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult dev(),
    @required TResult prod(),
    @required TResult test(),
  }) {
    assert(dev != null);
    assert(prod != null);
    assert(test != null);
    return test();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult dev(),
    TResult prod(),
    TResult test(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (test != null) {
      return test();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult dev(Dev value),
    @required TResult prod(Prod value),
    @required TResult test(Test value),
  }) {
    assert(dev != null);
    assert(prod != null);
    assert(test != null);
    return test(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult dev(Dev value),
    TResult prod(Prod value),
    TResult test(Test value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (test != null) {
      return test(this);
    }
    return orElse();
  }
}

abstract class Test implements Env {
  const factory Test() = _$Test;
}
