@extends('admin.layout')
@section('header')
    <!-- BEGIN THEME GLOBAL STYLES -->
    <link href="{{asset('src/plugins/src/noUiSlider/nouislider.min.css')}}" rel="stylesheet" type="text/css">
    <!-- END THEME GLOBAL STYLES -->

    <!--  BEGIN CUSTOM STYLE FILE  -->
    <link href="{{asset('src/assets/css/light/scrollspyNav.css')}}" rel="stylesheet" type="text/css" />
    <link href="{{asset('src/plugins/css/light/noUiSlider/custom-nouiSlider.css')}}" rel="stylesheet" type="text/css">
    <link href="{{asset('src/plugins/css/light/bootstrap-range-Slider/bootstrap-slider.css')}}" rel="stylesheet" type="text/css">

    <link href="{{asset('src/assets/css/dark/scrollspyNav.css')}}" rel="stylesheet" type="text/css" />
    <link href="{{asset('src/plugins/css/dark/noUiSlider/custom-nouiSlider.css')}}" rel="stylesheet" type="text/css">
    <link href="{{asset('src/plugins/css/dark/bootstrap-range-Slider/bootstrap-slider.css')}}" rel="stylesheet" type="text/css">
    <!--  END CUSTOM STYLE FILE  -->

@endsection


@section('panel')
<div class="middle-content container-xxl p-0">
    
                    <div class="row layout-spacing pt-3">
						<div class="col-lg-12 col-sm-12 col-12 layout-spacing">
                            <div class="statbox widget box box-shadow">
                                <div class="widget-header">                                
                                    <div class="row">
                                        <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                            <h4>اطلاعات سرویس</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="widget-content widget-content-area">
                                @if ($errors->any())
                            <div class="alert alert-danger">
                                <ul>
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif
                                    <form action="{{ route('admin.products.store') }}" method="POST" class="row w-100" enctype="multipart/form-data">

										@csrf
										<div class="col-lg-4 my-auto">
											<label for="name">عنوان محصول</label>
										</div>
										<div class="col-lg-8">
											<div class="input-group mb-3">
                                        		<input type="text" id="name" class="form-control" value="{{ old('name') }}" placeholder="عنوان" name="name">
											</div>
										</div>
										<div class="col-lg-4 my-auto">
											<label for="category">دسته</label>
										</div>
										<div class="col-lg-8">
											<div class="input-group mb-3">
												<select class="form-select " name="category_id" id="category">
													<option disabled selected>دسته</option>
                                                    @foreach ($categories as $category)
                                                        <option value="{{ $category->id }}" {{ old('category_id') == $category->id ? 'selected' : '' }}>{{ $category->name }}</option>
                                                    @endforeach
													
												</select>
											</div>
										</div>
										<div class="col-lg-4 my-auto">
											<label for="price">قیمت</label>
										</div>
										<div class="col-lg-8">
											<div class="input-group mb-3">
												<input type="text" name="price" value="{{ old('price') }}" class="form-control" id="price">
												<span class="input-group-text">تومان</span>
											</div>
										</div>
										<div class="col-lg-4 my-auto">
											<label for="descriptions">توضیحات</label>
										</div>
										<div class="col-lg-8">
											<div class="input-group">
                                            <textarea class="form-control" id="description" name="description" rows="5">{{ old('description') }}</textarea>
											</div>
										</div>
                                        <div class="col-lg-4 my-auto">
											<label for="descriptions">تصویر</label>
										</div>
										<div class="col-lg-8">
											<div class="input-group">
                                            <input type="file" class="form-control-file" id="image" name="image">
											</div>
										</div>
										
										<div class="col-lg-4 my-2">
                                        <button type="submit" class="btn btn-primary">ذخیره</button>
										</div>
									</form>

                                </div>
                            </div>
                        </div>
</div>
@endsection

@section('footer')
	<script src="{{asset('assets/js/jquery-3.6.3.min.js')}}"></script>
	<script>
		$('#category').on('change',function(){
			if($(this).find(':selected').attr("data-type") == 1){
				$('.size-box').slideDown();
				$('.duration-box').slideUp();
			} else {
				$('.duration-box').slideDown();
				$('.size-box').slideUp();
			}
		});
	</script>
@endsection