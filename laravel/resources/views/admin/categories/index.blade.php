@extends('admin.layout')
@section('header')

    <!-- BEGIN PAGE LEVEL CUSTOM STYLES -->
    <link href="../src/assets/css/light/scrollspyNav.css" rel="stylesheet" type="text/css" />
    <link href="../src/assets/css/dark/scrollspyNav.css" rel="stylesheet" type="text/css" />
    <!-- END PAGE LEVEL CUSTOM STYLES -->
@endsection
@section('panel')
<div class="middle-content container-xxl p-0">
                    <div class="row layout-spacing pt-3">
                        <div id="tableStriped" class="col-lg-12 col-12 layout-spacing">
                            <div class="statbox widget box box-shadow">
                                <div class="widget-header">
                                    <div class="row">
                                        <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                        <h4>لیست دسته بندی ها</h4>
                                        <a href="/admin/categories/create" class="btn btn-primary btn-sm">افزودن</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="widget-content widget-content-area">

                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                <th>#</th>
                                                <th>نام دسته بندی</th>
                                                <th>عملیات</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                 @foreach ($categories as $category)
													<tr>
                                                        <td>{{ $loop->iteration }}</td>
														<td>{{$category->name}}</td>
														<td>
                                                            <a href="{{ route('admin.categories.edit', $category->id) }}" class="btn btn-primary btn-sm">ویرایش</a>
                                                            <form action="{{ route('admin.categories.destroy', $category->id) }}" method="POST" class="d-inline">
                                                                @csrf
                                                                @method('DELETE')
                                                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('آیا از حذف دسته بندی {{ $category->name }} مطمئن هستید؟')">حذف</button>
                                                            </form>
                                                        </td>
														{{--<td class="text-center">
															<a class="btn btn-danger btn-sm mb-2 me-4 _effect--ripple waves-effect waves-light">Approved</a>
														</td>--}}
													</tr>
                                                @endforeach
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
    
                </div>
@endsection
@section('footer')
    <script src="../src/plugins/src/global/vendors.min.js"></script>
    <script src="../src/assets/js/custom.js"></script>

<script src="../src/plugins/src/table/datatable/datatables.js"></script>
    
@endsection