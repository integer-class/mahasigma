<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\CheckSkinController;
use App\Http\Controllers\Api\ProfileController;



Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/register', [AuthController::class, 'register'])->name('register');
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout']);

// Route::middleware('auth')->group(function () {
//     Route::get('/profile', [ProfileController::class, 'index'])->name('profile.index');
//     Route::post('/profile', [ProfileController::class, 'update'])->name('profile.update');
//     Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
// });

Route::get('/profile/{id}', [ProfileController::class, 'show'])->name('profile.show');


use App\Http\Controllers\Api\HistoryController;
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/history', [HistoryController::class, 'index']);
    Route::post('/history', [HistoryController::class, 'store']);
});

Route::get('/images/{path}', function ($path) {
    return response()->file(storage_path('app/public/scans/' . $path));
})->where('path', '.*');

Route::post('/check_skin', [CheckSkinController::class, 'index']);

use App\Http\Controllers\Api\DiseaseController;

Route::apiResource('/diseases', DiseaseController::class);

