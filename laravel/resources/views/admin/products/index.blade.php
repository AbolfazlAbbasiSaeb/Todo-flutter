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
                                            <h4>لیست محصول</h4>
                                            <a href="/admin/products/create" class="btn btn-primary btn-sm">افزودن</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="widget-content widget-content-area">

                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th scope="col">ردیف</th>
                                                    <th scope="col">عنوان</th>
                                                    <th scope="col">مبلغ</th>
                                                    <th scope="col">دسته بندی</th>
                                                    <th scope="col">تصویر</th>
                                                    <th scope="col">عملیات</th>
                                                </tr>
                                            </thead>
                                            <tbody>
												@foreach($products as $product)
													<tr>
														<td>{{$product->id}}</td>
                                                        <td>{{$product->name}}</td>
                                                        <td>{{$product->price}}</td>
														<td>{{$product->category->name}}</td>
                                                         <td>
                                                            <img src="{{ asset($product->image) }}" alt="{{ $product->name }}" width="50">
                                                        </td>
                                                    
														<td>
															<!-- <a href="">
																<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star fav-note"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
															</a> -->
															<a href="{{ route('admin.products.edit', $product->id) }}"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit-3"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg></a>
                                                            <form action="{{ route('admin.products.delete', $product) }}" method="POST">
                                                                @csrf
                                                                @method('DELETE')
                                                                <button style="border-color: white;" type="submit"><a href=""><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg></a></button>
                                                                
                                                            </form>
														</td>
													</tr>
                                                @endforeach
                                            </tbody>
                                        </table>
                                        {{ $products->links() }}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
    
                </div>
@endsection
@section('footer')
    
@endsection