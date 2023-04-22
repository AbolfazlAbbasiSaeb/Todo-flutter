<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\APIController;
use App\Http\Controllers\CategoryController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
Route::get('/doc-api', function () {
    return view('doc');
});
Auth::routes();

Route::get('/home', [App\Http\Controllers\APIController::class, 'index'])->name('admin.products.index');
Route::get('/admin/products',[App\Http\Controllers\APIController::class, 'index'])->name('admin.products.index');
// Route::get('/admin/products/edit/{id}',[App\Http\Controllers\APIController::class, 'index'])->name('admin.products.index');
Route::put('/products/{id}', [App\Http\Controllers\APIController::class, 'update'])->name('products.update');
Route::get('/admin/products/{product}/edit', [App\Http\Controllers\APIController::class, 'edit'])->name('admin.products.edit');
Route::delete('/admin/products/{product}', [App\Http\Controllers\APIController::class, 'delete'])->name('admin.products.delete');
Route::get('/admin/categories', [App\Http\Controllers\CategoryController::class, 'index'])->name('admin.categories.index');
Route::get('/admin/categories/create', [App\Http\Controllers\CategoryController::class, 'create'])->name('admin.categories.create');
Route::get('/categories/{id}/edit', [App\Http\Controllers\CategoryController::class, 'edit'])->name('admin.categories.edit');
Route::delete('/categories/{category}', [CategoryController::class, 'destroy'])->name('admin.categories.destroy');
Route::PUT('categories/{id}/edit', [CategoryController::class, 'update'])->name('admin.categories.update');
Route::get('/admin/categories/{category}/edit', [CategoryController::class, 'edit'])->name('admin.categories.edit');
Route::post('/admin/categories', [CategoryController::class, 'store'])->name('admin.categories.store');
Route::get('/admin/products/create', [APIController::class, 'create'])->name('admin.products.create');
Route::post('/admin/products', [APIController::class, 'store'])->name('admin.products.store');
Route::get('/sign-out', function () {
    Auth::logout();
    return redirect()->route('login');
})->name('logout');
