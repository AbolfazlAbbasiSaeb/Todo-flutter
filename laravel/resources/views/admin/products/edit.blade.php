@extends('admin.layout')
@section('header')

    <link rel="stylesheet" type="text/css" href="{{asset('src/assets/css/light/scrollspyNav.css')}}" />
    <link rel="stylesheet" type="text/css" href="{{asset('src/assets/css/light/forms/switches.css')}}" />

    <link rel="stylesheet" type="text/css" href="{{asset('src/assets/css/dark/scrollspyNav.css')}}" />
    <link rel="stylesheet" type="text/css" href="{{asset('src/assets/css/dark/forms/switches.css')}}" />

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
									<form action="{{ route('products.update', $product->id) }}" method="POST" class="row w-100">
                                    @csrf
                                    @method('PUT')
										<div class="col-lg-4 my-auto">
											<label for="name">عنوان محصول</label>
										</div>
										<div class="col-lg-8">
											<div class="input-group mb-3">
                                        		<input type="text" id="name" class="form-control" placeholder="عنوان" name="name" value="{{$product->name}}">
											</div>
										</div>                

										<div class="col-lg-4 my-auto">
											<label for="category">دسته</label>
										</div>
										<div class="col-lg-8">
											<div class="input-group mb-3">
												<select class="form-select " name="category_id" id="category">
													<option disabled selected>دسته</option>
                                                    @foreach($categories as $category)
                                                    <option value="{{ $category->id }}" {{ $product->category_id == $category->id ? 'selected' : '' }}>{{ $category->name }}</option>
													@endforeach
												</select>
											</div>
										</div>
									
										
										<div class="col-lg-4 my-auto">
											<label for="price">قیمت</label>
										</div>
										<div class="col-lg-8">
											<div class="input-group mb-3">
												<input type="text" name="price" value="{{$product->price}}" class="form-control" id="price">
												<span class="input-group-text">تومان</span>
											</div>
										</div>
										<div class="col-lg-4 my-auto">
											<label for="descriptions">توضیحات</label>
										</div>
										<div class="col-lg-8">
											<div class="input-group">
												<textarea class="form-control" name="description">{{$product->description}}</textarea>
											</div>
										</div>
										
										<div class="col-lg-4 my-2">
											<button class="btn btn-success mb-2 me-4">ثبت</button>
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
				$('.duration').slideUp();
			} else {
				$('.duration').slideDown();
				$('.size-box').slideUp();
			}
		});
	</script>
@endsection