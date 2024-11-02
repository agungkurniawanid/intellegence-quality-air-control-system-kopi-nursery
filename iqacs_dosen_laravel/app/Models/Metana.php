<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Metana extends Model
{
    use HasFactory;

    protected $table = 'metana';

    protected $fillable = ['id_alat', 'nilai_metana'];
}
