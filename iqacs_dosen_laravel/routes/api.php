<?php

use App\Http\Controllers\Api\MobileController;
use App\Http\Controllers\DeviceController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('gas/{id}', [MobileController::class, 'index']);

Route::controller(DeviceController::class)->prefix('/device')->group(function () {
    Route::post('/amonia', [DeviceController::class, 'amonia']);
    Route::post('/dioksida', [DeviceController::class, 'dioksida']);
    Route::post('/metana', [DeviceController::class, 'metana']);
    Route::post('/temperature', [DeviceController::class, 'temperature']);
    Route::post('/humidity', [DeviceController::class, 'humidity']);
});
