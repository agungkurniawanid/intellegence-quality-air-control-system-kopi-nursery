<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('monitoring_result_round_robins', function (Blueprint $table) {
            $table->id();
            $table->string('name_process')->nullable();
            $table->enum('method', ['Round Robin', 'Non Round Robin'])->default('Round Robin');
            $table->integer('burst_time')->nullable();
            $table->integer('waiting_time')->nullable();
            $table->integer('turn_around_time')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('monitoring_result_round_robins');
    }
};
