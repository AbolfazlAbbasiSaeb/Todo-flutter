
@extends('admin.layout')


@section('header')
@endsection

@section('panel')
<div class="middle-content container-xxl p-0">
    
                    <div class="row layout-spacing pt-3">
						<div class="col-lg-12 col-sm-12 col-12 layout-spacing">
                            <div class="statbox widget box box-shadow">
                                <div class="widget-header">                                
                                    <div class="row">
                                        <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                            <h4>اطلاعات دسته</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="widget-content widget-content-area">
									<form class="row w-100" method="POST" action="{{ route('admin.categories.update', $category->id) }}">
										@csrf
                                        @method('PUT')
										<div class="col-lg-4 my-auto">
											<label for="name">عنوان دسته</label>
										</div>
										<div class="col-lg-4">
											<div class="input-group mb-3">
                                        		<input type="text" id="name" value="{{ $category->name }}" class="form-control" placeholder="عنوان" name="name">
											</div>
										</div>
										<div class="col-lg-4 my-auto">
											@error('name')
												<span class="text-danger">{{$message}}</span>
											@enderror
										</div>
										<button type="submit" class="btn btn-secondary mb-2 me-4 _effect--ripple waves-effect waves-light">ثبت</button>
									</form>
                                </div>
                            </div>
                        </div>
</div>
@endsection

@section('footer')
@endsection