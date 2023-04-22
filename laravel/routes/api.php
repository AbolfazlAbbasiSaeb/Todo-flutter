<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\APIController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('register', [APIController::class, 'register'])->name('register.api'); // Signup
Route::post('login', [APIController::class, 'login'])->name('login.api'); // Login





Route::get('users', [APIController::class, 'getUsers']);
Route::get('products', [APIController::class, 'products']);
Route::get('categories/{id}', [APIController::class, 'categories']);
Route::get('todo/{id}', [APIController::class, 'todo']);
Route::post('todo/{id}', [APIController::class, 'todoStatus']);
Route::get('category/delete/{id}', [APIController::class, 'destroy']);
Route::get('todo/delete/{id}', [APIController::class, 'destroyTodo']);
Route::post('category/edit/{id}', [APIController::class, 'update']);
Route::post('todo/edit/{id}', [APIController::class, 'TodoUpdate']);
Route::post('CreateCategory', [APIController::class, 'storeAPI']);
Route::post('CreateTodo', [APIController::class, 'CreateTodo']);
Route::get('product', [APIController::class, 'search']);
