<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;

Route::middleware('api')->group(function () {
    Route::get('/products', [ProductController::class, 'index']);
    Route::get('/products/search/{query}', [ProductController::class, 'search']);
    Route::get('/products/{id}', [ProductController::class, 'show']);
});